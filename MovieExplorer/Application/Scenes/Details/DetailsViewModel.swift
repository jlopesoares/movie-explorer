//
//  DetailsViewModel.swift
//  MovieExplorer
//
//  Created by João Pedro on 21/02/2022.
//

import Foundation

final class DetailsViewModel: ObservableObject {
    
    let movieService: MovieService!
    let movieID: Int!
    
    @Published private(set) var movie: Movie?
    @Published private(set) var cast: [Cast]?
    
    init(movieService: MovieService, movieID: Int) {
        self.movieService = movieService
        self.movieID = movieID
    }
}

//MARK: - Services
extension DetailsViewModel {
    
    func fetchMovieDetails() async {
        do {
            self.movie = try await movieService.details(id: movieID)
            self.cast = try await movieService.fetchCast(for: movieID)
        } catch _ {}
    }
}
