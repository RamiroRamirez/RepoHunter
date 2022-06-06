//
//  RepositoriesViewModelTest.swift
//  RepoHunterTests
//
//  Created by Ramirez-Hernandez, Ramiro on 06.06.22.
//

import XCTest
import Foundation

@testable import RepoHunter

class RepositoriesViewModelTest: XCTestCase {
    
    var sut: RepositoriesViewModel!
    var repositoryService: MockRepositoryService!
    var appCoordinator: MockAppCoordinator!
    
    override func setUp() {
        repositoryService = MockRepositoryService()
        appCoordinator = MockAppCoordinator(mainNavigationController: UINavigationController())

        sut = RepositoriesViewModel(
            repositoryService: repositoryService,
            coordinator: appCoordinator
        )
    }
    
    func testFetchRepositoriesInformationHappens() {
        sut.searchRepositories(with: "someText")
        
        XCTAssert(repositoryService.fetchBranchesCalled)
        XCTAssert(repositoryService.fetchRepositoriesCalled)
        XCTAssert(sut.repositories.count == 1)
    }

    func testShowBranchesViewHappens() {
        sut.showRepositoryBranches(repository: RepositoryRepresentation(name: "SomeName", branches: []))

        XCTAssert(appCoordinator.showBranchesViewCalled)
    }

    func testShouldOnlyFetchTenItems() {
        repositoryService.repositoryResponse = .eleven
        repositoryService.fetchBranchesNumberOfCalls = 0

        sut.searchRepositories(with: "someText")
        
        XCTAssert(sut.repositories.count == 10)
        XCTAssert(repositoryService.fetchBranchesNumberOfCalls == 10)
    }
}
