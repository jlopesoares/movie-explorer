//
//  CastViewCell.swift
//  MovieExplorer
//
//  Created by João Pedro on 15/06/2023.
//

import SwiftUI
import Kingfisher

struct CastViewCell: View {
    
    var cast: Cast?
    
    var body: some View {
        KFImage(cast?.profileImageURL)
            .resizable()
            .centerCropped()
            .frame(width: 100, height: 100)
            .clipShape(RoundedRectangle(cornerRadius: 50))
    }
}
struct CastViewCell_Previews: PreviewProvider {
    static var previews: some View {
        CastViewCell()
    }
}
