//
//  AppCoordinator.swift
//  RepoHunter
//
//  Created by Ramirez-Hernandez, Ramiro on 05.06.22.
//

import Foundation
import UIKit

class AppCoordinator {

    var mainNavigationController: UINavigationController
    
    init(mainNavigationController : UINavigationController) {
        self.mainNavigationController = mainNavigationController
    }

    func start() {
        let viewModel = RepositoriesViewModel(coordinator: self)
        let repositoriesViewController = RepositoriesViewController(viewModel: viewModel)
        mainNavigationController.viewControllers = [repositoriesViewController]
    }

    func showBranchesView(branches: [Branch]) {
        let branchesViewController = BranchesViewController()
        mainNavigationController.pushViewController(branchesViewController, animated: true)
    }
}

