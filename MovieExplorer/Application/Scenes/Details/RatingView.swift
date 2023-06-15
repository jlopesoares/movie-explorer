//
//  RatingView.swift
//  MovieExplorer
//
//  Created by João Pedro on 12/06/2023.
//

import SwiftUI

struct RatingView: View {
    var body: some View {
        HStack {
            Image("starIcon")
            Image("starIcon")
            Image("starIcon")
            Image("starIcon")
            Image("starIcon")
        }
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView()
    }
}
