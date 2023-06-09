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

// MARK: - Datasource
extension CatalogViewModel {
    
    func rail(for indexPath: IndexPath) -> Rail {
        datasource[indexPath.section]
    }
    
    func item(for indexPath: IndexPath) -> AnyHashable {
        switch rail(for: indexPath).type {
        case .providers(let providers):
            return providers[indexPath.row]
            
        case .movies(let movies):
            return movies[indexPath.row]
        }
    }
}

// MARK: - Service
extension CatalogViewModel {
    
    func getMovies() async {
        
        await getPopular()
        await getMovieProviders()
        await getNowPlaying()
        await getUpcoming()
    }
    
    private func getPopular() async {
        
        let popularMovies = await service.fetchPopularMovies()
        
        let rail = Rail(name: "Popular", type: .movies(popularMovies))
        self.datasource.append(rail)
    }
    
    private func getMovieProviders() async {
        
        let movieProviders = await Array(service.fetchMovieProviders().sorted(by: { $0.id < $1.id }).prefix(10))
        let rail = Rail(name: "Providers", type: .providers(movieProviders))
        self.datasource.append(rail)
    }
    
    private func getNowPlaying() async {
        
        let nowPlayingMovies = await service.fetchNowPlayingMovies()
        
        let rail = Rail(name: "NowPlaying", type: .movies(nowPlayingMovies))
        self.datasource.append(rail)
    }
    
    private func getUpcoming() async {
        
        let upcomingMovies = await service.fetchUpcomingMovies()

        let rail = Rail(name: "Upcoming", type: .movies(upcomingMovies))
        self.datasource.append(rail)
    }
}
