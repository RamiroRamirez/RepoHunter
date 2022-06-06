//
//  MockRepositoryService.swift
//  RepoHunterTests
//
//  Created by Ramirez-Hernandez, Ramiro on 06.06.22.
//

import Foundation
import Combine
@testable import RepoHunter

enum RepositoryNumberResponse {
    case one
    case eleven
}

class MockRepositoryService: RepositoryService {
    
    var fetchRepositoriesCalled = false
    var fetchBranchesCalled = false
    
    var fetchBranchesNumberOfCalls = 0
    
    var repositoryResponse = RepositoryNumberResponse.one

    override func fetchRepositories(with repoName: String) -> AnyPublisher<[Repository], Error> {
        fetchRepositoriesCalled = true
        return Just(repositories()).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
    
    override func fetchBranches(for repository: Repository) -> AnyPublisher<[Branch], Error> {
        fetchBranchesCalled = true
        fetchBranchesNumberOfCalls += 1
        return Just([Branch(name: "someBranch")]).setFailureType(to: Error.self).eraseToAnyPublisher()
    }

    private func repositories() -> [Repository] {
        switch repositoryResponse {
        case .one:
            return createRepositories(number: 1)
        case .eleven:
            return createRepositories(number: 11)
        }
    }
    
    private func createRepositories(number: Int) -> [Repository] {
        let baseRepositoryName = "name"
        let baseRepositoryFullName = "fullname"
        
        var repositories = [Repository]()
        
        for index in (1...number) {
            let repository = Repository(
                name: "\(baseRepositoryName) \(index)",
                fullName: "\(baseRepositoryFullName) \(index)"
            )
            
            repositories.append(repository)
        }
        
        return repositories
    }
}
