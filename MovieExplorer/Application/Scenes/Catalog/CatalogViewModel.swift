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
}

//MARK: - Service
extension CatalogViewModel {
    
    func getMovies() async {
        
        await getPopular()
        await getNowPlaying()
        await getUpcoming()
    }
    
    private func getPopular() async {
        
        let popularMovies = await service.fetchPopularMovies()
        
        let rail = Rail(name: "Popular", movies: popularMovies)
        self.datasource.append(rail)
    }
    
    private func getNowPlaying() async {
        
        let nowPlayingMovies = await service.fetchNowPlayingMovies()
        
        let rail = Rail(name: "NowPlaying", movies: nowPlayingMovies)
        self.datasource.append(rail)
    }
    
    private func getUpcoming() async {
        
        let upcomingMovies = await service.fetchUpcomingMovies()

        let rail = Rail(name: "Upcoming", movies: upcomingMovies)
        self.datasource.append(rail)
    }
    
    private func getMovieProviders() async {
        
        let movieProviders = await service.fetchMovieProviders().sorted(by: { $0.id < $1.id })
        print(movieProviders)
    }
}
