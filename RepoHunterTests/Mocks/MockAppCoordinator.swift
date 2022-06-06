//
//  MockAppCoordinator.swift
//  RepoHunterTests
//
//  Created by Ramirez-Hernandez, Ramiro on 06.06.22.
//

import Foundation

@testable import RepoHunter

class MockAppCoordinator: AppCoordinator {
    
    var startCalled = false
    var showBranchesViewCalled = false
    
    override func start() {
        startCalled = true
    }

    override func showBranchesView(branches: [Branch]) {
        showBranchesViewCalled = true
    }
}
