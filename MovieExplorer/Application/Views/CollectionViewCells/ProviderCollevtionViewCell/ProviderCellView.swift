//
//  ProviderCellView.swift
//  MovieExplorer
//
//  Created by João Pedro on 06/06/2023.
//

import SwiftUI

struct ProviderCellView: View {
    var body: some View {
        ZStack {
            Color.white
            Image("disney")
                .centerCropped()
                .scaledToFit()
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
