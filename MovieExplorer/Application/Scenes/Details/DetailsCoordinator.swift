//
//  DetailsCoordinator.swift
//  MovieExplorer
//
//  Created by João Pedro on 09/02/2022.
//

import UIKit
import SwiftUI

class DetailsCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var movieID: Int
    
    init(navigationController: UINavigationController, movieID: Int) {
        self.navigationController = navigationController
        self.movieID = movieID
    }
    
    func start() {
        navigationController.setNavigationBarHidden(false, animated: true)
        
        let viewModel = DetailsViewModel(movieService: MovieService(tmdbServices: TMDBServices()),
                                         movieID: movieID)
        let hostingController = UIHostingController(rootView: DetailView(viewModel: viewModel))
        navigationController.pushViewController(hostingController, animated: true)
    }
}
