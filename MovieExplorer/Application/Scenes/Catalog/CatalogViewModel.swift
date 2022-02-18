//
//  CatalogViewModel.swift
//  MovieExplorer
//
//  Created by João Pedro on 09/02/2022.
//

import Foundation

final class CatalogViewModel {
    
    let service: MovieService
    var datasource = [Rail]()
    
    init(service: MovieService) {
        self.service = service
    }

    //MARK: - Service
    func getMovies(completion: @escaping () -> ()) {
        
        var gotPopular = false
        var gotNowPlaying = false
        var gotUpcoming = false
        
        getPopular {
            gotPopular = true
            
            if gotPopular && gotNowPlaying && gotUpcoming {
                completion()
            }
        }
        
        getNowPlaying {
            gotNowPlaying = true
            
            if gotPopular && gotNowPlaying && gotUpcoming {
                completion()
            }
        }
        
        getUpcoming {
            gotUpcoming = true
            
            if gotPopular && gotNowPlaying && gotUpcoming {
                completion()
            }
        }
    }
    
    private func getPopular(completion: @escaping () -> ()) {
        
        service.fetchMovies(with: .popular) { movie in
            
            let rail = Rail(name: MovieEndpoints.popular.description, movies: movie.results)
            self.datasource.append(rail)
            
            completion()
        } failure: { error in
            print(error)
        }
    }
    
    private func getNowPlaying(completion: @escaping () -> ()) {
        
        service.fetchMovies(with: .nowPlaying) { movie in
            let rail = Rail(name: MovieEndpoints.nowPlaying.description, movies: movie.results)
            self.datasource.append(rail)
            completion()
        } failure: { error in
            print(error)
        }
    }
    
    private func getUpcoming(completion: @escaping () -> ()) {
        
        service.fetchMovies(with: .upcoming) { movie in
            
            let rail = Rail(name: MovieEndpoints.upcoming.description, movies: movie.results)
            self.datasource.append(rail)
            
            completion()
        } failure: { error in
            print(error)
        }
    }
}
