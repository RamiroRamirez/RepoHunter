//
//  BranchesViewModel.swift
//  RepoHunter
//
//  Created by Ramirez-Hernandez, Ramiro on 05.06.22.
//

import Foundation

class BranchesViewModel: ObservableObject {
    
    var branches: [Branch]
    
    init(branches: [Branch]) {
        self.branches = branches
    }
}
