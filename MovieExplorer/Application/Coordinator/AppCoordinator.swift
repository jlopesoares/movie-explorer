//
//  AppCoordinator.swift
//  MovieExplorer
//
//  Created by João Pedro on 09/02/2022.
//

import UIKit

class AppCoordinator: Coordinator {
   
    var navigationController: UINavigationController

    var childCoordinators = [Coordinator]()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let catalogCoordinator = CatalogCoordinator(navigationController: navigationController)
        catalogCoordinator.start()
        childCoordinators.append(catalogCoordinator)
    }

    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
}
