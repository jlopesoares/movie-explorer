//
//  DetailsCoordinator.swift
//  MovieExplorer
//
//  Created by João Pedro on 09/02/2022.
//

import UIKit

class DetailsCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    var movieIdentifier: String
    
    init(navigationController: UINavigationController, movieIdentifier: String) {
        
        self.navigationController = navigationController
        self.movieIdentifier = movieIdentifier
    }
    
    func start() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: String(describing: DetailsViewController.self)) as! DetailsViewController
        
        let viewModel = DetailsViewModel(movieService: MovieService(tmdbServices: TMDBServices()), movieId: movieIdentifier)
        vc.viewModel = viewModel
        
        navigationController.pushViewController(vc, animated: true)
    }
    
}
