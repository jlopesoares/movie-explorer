//
//  DetailsBackgroundView.swift
//  MovieExplorer
//
//  Created by João Pedro on 12/06/2023.
//

import SwiftUI
import Kingfisher

struct DetailsBackgroundView: View {
    
    var movie: Movie?
    
    var body: some View {
        KFImage(movie?.getPosterURL(size: .medium))
            .resizable()
            .ignoresSafeArea()
            .scaledToFill()
        
        LinearGradient(colors:
                        [.black.opacity(0.26),
                         .black.opacity(0.9)],
                       startPoint: .top,
                       endPoint: .bottom)
        .ignoresSafeArea()
    }
}

struct DetailsBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsBackgroundView()
    }
}
