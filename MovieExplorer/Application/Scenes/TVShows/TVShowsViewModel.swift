//
//  TVShowsViewModel.swift
//  MovieExplorer
//
//  Created by João Pedro on 15/06/2023.
//

import Foundation

final class TVShowsViewModel: ObservableObject {
    
    let tvShowsService: TVShowsService
    @Published private(set) var tvShows: [TVShow] = []
    
    init(tvShowsService: TVShowsService) {
        self.tvShowsService = tvShowsService
    }
    
    func fetchPopularTVShows() async {
        do {
            let shows = try await tvShowsService.fetchPopularTVShows()
            tvShows = shows
        } catch _ {
            
        }
    }
}
