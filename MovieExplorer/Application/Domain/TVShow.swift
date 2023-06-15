//
//  TVShow.swift
//  MovieExplorer
//
//  Created by João Pedro on 15/06/2023.
//

import Foundation
import TMDb

struct TVShow: Identifiable, ImageUseCase, Hashable {
    var id: Int
    var name: String
    let posterURL: URL?
    let backdropURL: URL?
    
    init(tvShow: TMDb.TVShow) {
        self.id = tvShow.id
        self.name = tvShow.name
        self.posterURL = tvShow.posterPath
        self.backdropURL = tvShow.backdropPath
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    func getPosterURL(with size: ImageSize) -> URL? {
        getImageUrl(for: posterURL?.absoluteString, with: size)
    }
}
