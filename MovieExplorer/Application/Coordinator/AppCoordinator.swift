//
//  AppCoordinator.swift
//  MovieExplorer
//
//  Created by João Pedro on 09/02/2022.
//

import UIKit

class AppCoordinator {
   
    var tabBarController: UITabBarController

    var childCoordinators = [Coordinator]()
    
    init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
    }

    func start() {
        
        let moviesNavigationController = UINavigationController()
        let catalogCoordinator = CatalogCoordinator(navigationController: moviesNavigationController)
        catalogCoordinator.start()
        moviesNavigationController.tabBarItem = UITabBarItem(title: "Movies",
                                                             image: .init(systemName: "popcorn"),
                                                             selectedImage: .init(systemName: "popcorn.fill"))
        moviesNavigationController.toolbar.tintColor = UIColor(named: "mainTintColor")
        
        moviesNavigationController.setNavigationBarHidden(true, animated: false)
        
        childCoordinators.append(catalogCoordinator)
        
        let tvShowsNavigationController = UINavigationController()
        let tvShowsCoordinator = TVShowCoordinator(navigationController: tvShowsNavigationController)
        tvShowsCoordinator.start()
        tvShowsNavigationController.tabBarItem = UITabBarItem(title: "TV Shows",
                                                              image: .init(systemName: "tv"),
                                                              selectedImage: .init(systemName: "tv.fill"))
        

        tvShowsNavigationController.setNavigationBarHidden(true, animated: false)
        
        
        childCoordinators.append(tvShowsCoordinator)
        
        tabBarController.tabBar.tintColor = UIColor(named: "mainTintColor")
        
        tabBarController.setViewControllers([moviesNavigationController, tvShowsNavigationController], animated: false)
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
