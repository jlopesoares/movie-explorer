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
        
        getPopular {
            gotPopular = true
            
            if gotPopular && gotNowPlaying {
                completion()
            }
        }
        
        getNowPlaying {
            gotNowPlaying = true
            
            if gotPopular && gotNowPlaying {
                completion()
            }
            
        }
    }
    
    private func getPopular(completion: @escaping () -> ()) {
        
        service.fetchMovies(with: .popular) { movie in
            
            let rail = Rail(name: "Popular", movies: movie.results)
            self.datasource.append(rail)
            
            completion()
        } failure: { error in
            print(error)
        }
    }
    
    private func getNowPlaying(completion: @escaping () -> ()) {
        
        service.fetchMovies(with: .nowPlaying) { movie in
            
            let rail = Rail(name: "now playing", movies: movie.results)
            self.datasource.append(rail)
            completion()
        } failure: { error in
            print(error)
        }
    }
    
    
}
