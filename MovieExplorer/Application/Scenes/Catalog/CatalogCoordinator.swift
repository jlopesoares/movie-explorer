//
//  CatalogCoordinator.swift
//  MovieExplorer
//
//  Created by João Pedro on 09/02/2022.
//

import Foundation
import UIKit

protocol DetailCoordinateFlow: AnyObject {
    
    func coordinateToDetail()
}

class CatalogCoordinator: Coordinator, DetailCoordinateFlow {
    
    //MARK: - Properties
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    //MARK: - Init
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: String(describing: CatalogViewController.self)) as! CatalogViewController
        vc.catalogCoordinator = self
        navigationController.setViewControllers([vc], animated: false)
    }
    
    
    //MARK: - Coordinates
    func coordinateToDetail() {
        
        let childCoordinator = DetailsCoordinator(navigationController: navigationController)
        
        childCoordinators.append(childCoordinator)
        
        childCoordinator.start()
        
    }
}