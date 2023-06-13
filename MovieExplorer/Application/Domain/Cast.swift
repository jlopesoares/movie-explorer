//
//  Cast.swift
//  MovieExplorer
//
//  Created by João Pedro on 24/02/2022.
//

import Foundation
import TMDb

public struct Cast: Codable, Hashable, ImageUseCase {
    
    let id: Int
    let name: String
    let profilePath: String?
    
    public var profileImageURL: URL? {
        getImageUrl(for: profilePath, with: .small)
    }
    
    init(castMember: CastMember) {
        self.id = castMember.id
        self.name = castMember.name
        self.profilePath = castMember.profilePath?.absoluteString
    }
    
}
