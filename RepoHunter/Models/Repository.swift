//
//  Repository.swift
//  RepoHunter
//
//  Created by Ramirez-Hernandez, Ramiro on 05.06.22.
//

import Foundation

class Repository: Decodable {
    let name: String
    let full_name: String
    
    init(name: String, fullName: String) {
        self.name = name
        self.full_name = fullName
    }
}
