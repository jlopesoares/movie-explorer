//
//  DetailsViewModel.swift
//  MovieExplorer
//
//  Created by João Pedro on 21/02/2022.
//

import Foundation

enum DetailSections: Hashable {
    case header
    case cast
    
}

enum DetailModelType: Hashable {
    
    case detailSection(Movie?)
    case cast(Cast)
}

final class DetailsViewModel {
    
    let movieService: MovieService!
    let movieId: String!
    
    var movie: Movie?
    var cast: [Cast]?
    
    
    func datasource(for section: DetailSections) -> [DetailModelType] {
        
        switch section {
            case .header:
                return [.detailSection(self.movie)]
            case .cast:
                
                guard let cast = cast else {
                    return []
                }

                return cast.map({ DetailModelType.cast($0) })
        }
        
    }
    
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
    
    func fetchMovieCast(completion: @escaping MovieCastCompletion) {
        
        movieService.getMovieCast(for: movieId) { result in
            switch result {
                case .success(let cast):
                    self.cast = cast
                    
                case .failure(_):
                    break
            }
            
            completion(result)
        }
    }
    
}
