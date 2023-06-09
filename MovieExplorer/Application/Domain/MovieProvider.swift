//
//  MovieProvider.swift
//  MovieExplorer
//
//  Created by João Pedro on 05/06/2023.
//

import Foundation
import TMDb

struct MovieProvider: Identifiable, Codable, Hashable, ImageUseCase {
    
    var id: Int
    var name: String
    var logo: URL
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    init(watchProvider: WatchProvider) {
        id = watchProvider.id
        name = watchProvider.name
        logo = watchProvider.logoPath
    }
    
    var logoURL: URL? {
        getImageUrl(for: logo.absoluteString, with: .small)
    }
}
