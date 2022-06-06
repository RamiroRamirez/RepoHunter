//
//  Branch.swift
//  RepoHunter
//
//  Created by Ramirez-Hernandez, Ramiro on 05.06.22.
//

import Foundation

class Branch: Decodable, Hashable {
    let name: String
    
    init(name: String) {
        self.name = name
    }
    
    static func == (lhs: Branch, rhs: Branch) -> Bool {
        return lhs.name == rhs.name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}
