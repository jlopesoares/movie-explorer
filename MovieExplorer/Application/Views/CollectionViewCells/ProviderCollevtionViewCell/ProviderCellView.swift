//
//  ProviderCellView.swift
//  MovieExplorer
//
//  Created by João Pedro on 06/06/2023.
//

import SwiftUI
import Kingfisher

struct ProviderCellView: View {
    
    var movieProvider: MovieProvider?
    
    var body: some View {
        ZStack {
            Color.white
            KFImage(movieProvider?.logoURL)
                .centerCropped()
                .scaledToFit()
                .padding(8)
        }
        .cornerRadius(10)
    }
}

struct ProviderCellView_Previews: PreviewProvider {
    static var previews: some View {
        ProviderCellView()
            .previewLayout(.fixed(width: 131, height: 61))
    }
}
