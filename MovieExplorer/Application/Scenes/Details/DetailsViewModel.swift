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
    let movieID: Int!
    
    var movie: Movie?
    var cast: [Cast]?
    
    init(movieService: MovieService, movieID: Int) {
        self.movieService = movieService
        self.movieID = movieID
    }
    
    func datasource(for section: DetailSections) -> [AnyHashable] {
        
        switch section {
            case .header:
                
                guard let movie = movie else {
                    return []
                }
                
                return [movie]
                
            case .cast:
                
                guard let cast = cast else {
                    return []
                }
                
                return cast
        }
    }
}

//MARK: - Services
extension DetailsViewModel {
    
    func fetchMovieDetails() async -> Result<Void, Error> {
        do {
            self.movie = try await movieService.details(id: movieID)
            return .success(())
        } catch let error {
            return .failure(error)
        }
    }
    
    func fetchMovieCast(completion: @escaping MovieCastCompletion) {
        
//        movieService.getMovieCast(for: movieId) { result in
//            switch result {
//                case .success(let cast):
//                    self.cast = cast
//
//                case .failure(_):
//                    break
//            }
//
//            completion(result)
//        }
    }
}
