//
//  MovieCellView.swift
//  MovieExplorer
//
//  Created by João Pedro on 06/06/2023.
//

import SwiftUI
import Kingfisher

struct MovieCellView: View {
    
    var movie: Movie?
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.white
            
            VStack(spacing: 8) {
                
                KFImage(movie?.getBackdropURL)
                    .centerCropped()
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    .padding(.horizontal, 8)
                    .padding(.top, 5)
                    .frame(height: 155, alignment: .center)
                    
                Text(movie?.title ?? "")
                    .font(.system(size: 15, weight: .semibold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 8)
                
                HStack(alignment: .center) {
                    Text("1h57m")
                        .font(.system(size: 12, weight: .medium))
                        .padding(.leading, 8)
                        .foregroundColor(.black.opacity(0.7))
                    
                    Spacer()
                    Image("playIcon")
                        .resizable()
                        .frame(width: 37, height: 37)
                    Spacer()
                    
                    MovieRatingView()
                        .padding(.trailing, 8)
                }
                .padding(.bottom, 6)
            }
            .clipped()
        }
        .cornerRadius(25)
    }
}

extension KFImage {
    func centerCropped() -> some View {
        GeometryReader { geo in
            self
            .resizable()
            .scaledToFill()
            .frame(width: geo.size.width, height: geo.size.height)
        }
    }
}

private struct MovieRatingView: View {
    var body: some View {
        HStack() {
            Text("8.9")
                .font(.system(size: 12, weight: .semibold))
            Image("starIcon")
                .resizable()
                .frame(width: 13, height: 13)
        }
    }
}

struct MovieCellView_Previews: PreviewProvider {
    static var previews: some View {
        MovieCellView()
            .previewLayout(.fixed(width: 241, height: 237))
    }
}
