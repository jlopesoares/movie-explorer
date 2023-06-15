//
//  DetailsSinopseView.swift
//  MovieExplorer
//
//  Created by João Pedro on 15/06/2023.
//

import SwiftUI

struct DetailsSinopseView: View {
    var movie: Movie?
    var cast: [Cast]?
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text("Overview")
                .font(.system(size: 24))
                .fontWeight(.bold)
                .padding()
            
            Text(movie?.overview ?? "")
                .font(.system(size: 16))
                .padding()
            
            Text("Cast And Crew")
                .font(.system(size: 24))
                .fontWeight(.bold)
                .padding()
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(cast ?? [], id: \.id) { cast in
                        CastViewCell(cast: cast)
                    }
                }
                .ignoresSafeArea()
            }
            .ignoresSafeArea()
        }
        .padding()
        .ignoresSafeArea()
    }
}

struct DetailsSinopseView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsSinopseView()
    }
}
