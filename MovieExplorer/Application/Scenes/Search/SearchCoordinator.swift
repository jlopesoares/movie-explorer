//
//  SearchCoordinator.swift
//  MovieExplorer
//
//  Created by João Pedro Soares on 27/07/2023.
//

import UIKit

class SearchCoordinator: Coordinator, DetailCoordinateFlow {
    
    //MARK: - Properties
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    //MARK: - Init
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: String(describing: SearchViewController.self)) as! SearchViewController
        
        let viewModel = SearchViewModel(service: SearchService(tmdbServices: TMDBServices()))
        
        vc.coordinator = self
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
