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
    
    var movieID: Int
    
    init(navigationController: UINavigationController, movieID: Int) {
        
        self.navigationController = navigationController
        self.movieID = movieID
    }
    
    func start() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: String(describing: DetailsViewController.self)) as! DetailsViewController
        
        let viewModel = DetailsViewModel(movieService: MovieService(tmdbServices: TMDBServices()),
                                         movieID: movieID)
        vc.viewModel = viewModel
        
        navigationController.pushViewController(vc, animated: true)
    }
    
}
