//
//  DetailsViewModel.swift
//  MovieExplorer
//
//  Created by João Pedro on 21/02/2022.
//

import Foundation

enum DetailSections {
    case header
    case rails
    
    enum DetailModelType {
        
        case detailSection(Movie)
        case rails(Movie)
    }
}

final class DetailsViewModel {
    
    let movieService: MovieService!
    let movieId: String!
    
    var movie: Movie?
    
    init(movieService: MovieService, movieId: String) {
        self.movieService = movieService
        self.movieId = movieId
    }
    
    func fetchMovieDetails(completion: @escaping MovieDetailCompletion) {
        
        movieService.getMovieDetail(for: movieId) { result in
            switch result {
                case .success(let movie):
                    self.movie = movie
                    
                case .failure(_):
                    break
            }
            
            completion(result)
        }
    }
}
