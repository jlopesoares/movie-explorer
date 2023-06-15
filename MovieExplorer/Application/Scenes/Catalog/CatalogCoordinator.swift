//
//  CatalogCoordinator.swift
//  MovieExplorer
//
//  Created by João Pedro on 09/02/2022.
//

import Foundation
import UIKit
import SwiftUI

protocol DetailCoordinateFlow: AnyObject {
    
    func coordinateToDetail(with movieID: Int)
}

final class HostingController<Content: View>: UIHostingController<Content> {
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        view.setNeedsUpdateConstraints()
    }
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
        
        let viewModel = CatalogViewModel(service: MovieService(tmdbServices: TMDBServices()))
        
        vc.catalogCoordinator = self
        vc.viewModel = viewModel
        
        navigationController.setViewControllers([vc], animated: false)
    }
    
    
    //MARK: - Coordinates
    func coordinateToDetail(with movieID: Int) {
        
        let childCoordinator = DetailsCoordinator(navigationController: navigationController, movieID: movieID)
        
        childCoordinators.append(childCoordinator)
        
        childCoordinator.start()
        
    }
}
