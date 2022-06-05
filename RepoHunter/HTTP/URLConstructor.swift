//
//  URLConstructor.swift
//  RepoHunter
//
//  Created by Ramirez-Hernandez, Ramiro on 05.06.22.
//

import Foundation

class URLConstructor {
    
    private func baseURLComponents() -> URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.github.com"
        
        return components
    }

    func repositorySearchURL(with queryItems: [URLQueryItem] = []) -> URL? {
        var components = self.baseURLComponents()
        components.path = "/search/repositories"
        components.queryItems = queryItems
        
        return components.url
    }

    func branchesSearchURL(for repoFullName: String) -> URL? {
        var components = self.baseURLComponents()
        components.path = "/repos/\(repoFullName)/branches"

        return components.url
    }
}
