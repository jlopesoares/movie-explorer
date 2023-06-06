//
//  MovieProvider.swift
//  MovieExplorer
//
//  Created by João Pedro on 05/06/2023.
//

import Foundation
import TMDb

struct MovieProvider: Identifiable, Codable, ImageUseCase {
    
    var id: Int
    var name: String
    var logo: URL
    
    init(watchProvider: WatchProvider) {
        id = watchProvider.id
        name = watchProvider.name
        logo = watchProvider.logoPath
    }
}
