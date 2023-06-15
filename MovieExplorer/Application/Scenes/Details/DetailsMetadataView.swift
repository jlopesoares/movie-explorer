//
//  DetailsMetadataView.swift
//  MovieExplorer
//
//  Created by João Pedro on 12/06/2023.
//

import SwiftUI

struct DetailsMetadataView: View {
    
    var movie: Movie?
    
    var body: some View {
        GeometryReader { proxy in
            
            VStack(spacing: 24) {
                Spacer()
                Spacer()
                Spacer()
                Text(movie?.title ?? "")
                    .fontWeight(.bold)
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .frame(width: proxy.size.width)
                
                Text(movie?.metadata ?? "")
                    .font(.headline)
                    .foregroundColor(.white)
                
                RatingView()
                
                Button {
                    
                } label: {
                    Image("playIconWhite")
                        .resizable()
                        .frame(width: 100, height: 100)
                }
                
                Spacer()
                
                Group {
                    Text("See More")
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
                        .foregroundColor(Color("mainBackgroundColor"))
                    
                    Image("arrowBottomIcon")
                        .padding(.bottom, 20)
                }
                .padding(.bottom, 16)
            }
            .frame(width: proxy.size.width)
        }
    }
}

struct DetailsMetadataView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsMetadataView()
    }
}
