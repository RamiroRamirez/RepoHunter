//
//  RepositoriesViewController.swift
//  RepoHunter
//
//  Created by Ramirez-Hernandez, Ramiro on 05.06.22.
//

import UIKit
import Combine

class RepositoriesViewController: UIViewController {
    
    private let viewModel: RepositoriesViewModel
    private var searchBar: UISearchBar?
    private var repositories = [RepositoryRepresentation]()
    private var subscriptions = [AnyCancellable]()
    
    let tableView : UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    init(viewModel: RepositoriesViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        createUIElements()
        initBinding()
    }

    private func createUIElements() {
        configureSearchBar()
        configureTableView()
    }

    private func configureSearchBar() {
        searchBar = UISearchBar()
        searchBar?.sizeToFit()
        searchBar?.delegate = self

        navigationItem.titleView = searchBar
    }

    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "RepositoryCell")

        self.view.addSubview(tableView)
        
        let constraints = [
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        ]

        NSLayoutConstraint.activate(constraints)
    }

    private func initBinding() {
        viewModel
            .$repositories
            .receive(on: RunLoop.main)
            .sink { [weak self] repositories in
                self?.repositories = repositories
                self?.tableView.reloadData()
                self?.searchBar?.resignFirstResponder()
                self?.showNoBranchesBackground()
            }
            .store(in: &subscriptions)
    }

    private func resetSearch() {
        repositories.removeAll()
        searchBar?.resignFirstResponder()
        showNoBranchesBackground()
        tableView.reloadData()
    }
    
    private func showNoBranchesBackground() {
        let backgroundLabel = UILabel()
        backgroundLabel.text = "No search results for now!"
        backgroundLabel.textAlignment = .center
        tableView.backgroundView = backgroundLabel
    }
    
    private func showActivityIndicator() {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.startAnimating()
        tableView.backgroundView = spinner
    }

    private func hideTableViewBackground() {
        tableView.backgroundView = nil
    }
}

extension RepositoriesViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard
            let searchText = searchBar.text,
            searchText.trimmingCharacters(in: .whitespaces).isEmpty == false else {
                resetSearch()
                return
        }
          
        showActivityIndicator()
        viewModel.searchRepositories(with: searchText)
    }
}

extension RepositoriesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryCell"),
            let repository = repositories[safe: indexPath.row] else {
                return UITableViewCell()
        }

        var content = cell.defaultContentConfiguration()
        content.text = repository.name
        content.secondaryText = "# of branches: \(repository.branches.count)"
        cell.contentConfiguration = content
        
        return cell
    }
}

extension RepositoriesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let repository = repositories[safe: indexPath.row] else {
            return
        }
        
        viewModel.showRepositoryBranches(repository: repository)
    }
}
