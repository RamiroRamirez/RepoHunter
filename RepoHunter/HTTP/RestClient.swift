//
//  RestClient.swift
//  RepoHunter
//
//  Created by Ramirez-Hernandez, Ramiro on 04.06.22.
//

import Foundation
import Combine

class RestClient {
    
    func request<T: Decodable>(
        url: URL,
        method: HTTPMethod,
        type: T.Type
    ) -> AnyPublisher<T, Error> {
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        return URLSession
            .shared
            .dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
