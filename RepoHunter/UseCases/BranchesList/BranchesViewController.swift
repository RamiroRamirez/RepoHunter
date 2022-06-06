//
//  BranchesViewController.swift
//  RepoHunter
//
//  Created by Ramirez-Hernandez, Ramiro on 05.06.22.
//

import UIKit

class BranchesViewController: UIViewController {
    
    private let viewModel: BranchesViewModel

    convenience init() {
        self.init(viewModel: BranchesViewModel())
    }
    
    init(viewModel: BranchesViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
