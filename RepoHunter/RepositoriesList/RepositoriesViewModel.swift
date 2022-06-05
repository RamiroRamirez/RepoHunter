//
//  RepositoriesViewModel.swift
//  RepoHunter
//
//  Created by Ramirez-Hernandez, Ramiro on 05.06.22.
//

import Foundation
import Combine
import UIKit

struct RepositoryRepresentation {
    let name: String
    let branches: [Branch]
}

class RepositoriesViewModel {
    
    let repositoryService: RepositoryService
    weak var coordinator: AppCoordinator?
    @Published var repositories = [RepositoryRepresentation]()
    
    private var subscriptions = [AnyCancellable]()
    
    convenience init(coordinator: AppCoordinator) {
        self.init(repositoryService: RepositoryService(), coordinator: coordinator)
    }

    init(repositoryService: RepositoryService, coordinator: AppCoordinator) {
        self.repositoryService = repositoryService
    }

    func searchRepositories(with name: String) {
        repositoryService
            .fetchRepositories(with: name)
            .map { $0.prefix(10) }
            .flatMap { $0.publisher.setFailureType(to: Error.self) }
            .flatMap({ repository in
                self.repositoryService.fetchBranches(for: repository)
                    .map { branches in
                        RepositoryRepresentation(
                            name: repository.name,
                            branches: branches
                        )
                    }
            })
            .collect()
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { repositories in
                    self.repositories = repositories
                }
            )
            .store(in: &subscriptions)
    }
    
    func showRepositoryBranches(repository: RepositoryRepresentation) {
        coordinator?.showBranchesView(branches: repository.branches)
    }
}
