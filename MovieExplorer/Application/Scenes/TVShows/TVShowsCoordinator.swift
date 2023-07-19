//
//  TVShowsCoordinator.swift
//  MovieExplorer
//
//  Created by João Pedro on 15/06/2023.
//

import SwiftUI
import UIKit

protocol TVShowCoordinateFlow: AnyObject {
    
}

final class TVShowCoordinator: Coordinator, DetailCoordinateFlow {
    
    //MARK: - Properties
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    //MARK: - Init
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        
        let viewModel = TVShowsViewModel(tvShowsService: TVShowsService(tmdbServices: TMDBServices()))
        let tvShowsHostingController = HostingController(rootView: TVShowsView(viewModel: viewModel))
        navigationController.setViewControllers([tvShowsHostingController], animated: false)
        
    }
    
    
    //MARK: - Coordinates
    func coordinateToDetail(with movieID: Int) {
        
        let childCoordinator = DetailsCoordinator(navigationController: navigationController, movieID: movieID)
        
        childCoordinators.append(childCoordinator)
        
        childCoordinator.start()
        
    }
}
