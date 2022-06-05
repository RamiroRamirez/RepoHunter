//
//  RepositoryService.swift
//  RepoHunter
//
//  Created by Ramirez-Hernandez, Ramiro on 05.06.22.
//

import Foundation
import Combine

class RepositoryService {
    
    private var restClient: RestClient
    private var urlConstructor: URLConstructor
    
    init(
        restClient: RestClient,
        urlConstructor: URLConstructor
    ) {
        self.restClient = restClient
        self.urlConstructor = urlConstructor
    }

    convenience init() {
        self.init(
            restClient: RestClient(),
            urlConstructor: URLConstructor()
        )
    }

    func fetchRepositories(with repoName: String) -> AnyPublisher<[Repository], Error> {
        let queryItem = URLQueryItem(name: "q", value: repoName)
        guard let url = urlConstructor.repositorySearchURL(with: [queryItem]) else {
            return Fail(error: RepositoryServiceError.wrongURL)
                .eraseToAnyPublisher()
        }

        return restClient
            .request(
                url: url,
                method: .get,
                type: Repositories.self
            )
            .map { $0.items }
            .eraseToAnyPublisher()
    }
    
    func fetchBranches(for repository: Repository) -> AnyPublisher<[Branch], Error> {
        guard let url = urlConstructor.branchesSearchURL(for: repository.full_name) else {
            return Fail(error: RepositoryServiceError.wrongURL)
                .eraseToAnyPublisher()
        }

        return restClient
            .request(
                url: url,
                method: .get,
                type: [Branch].self
            )
            .eraseToAnyPublisher()
    }
    
    enum RepositoryServiceError: Error {
        case wrongURL
    }
}
