//
//  DetailView.swift
//  MovieExplorer
//
//  Created by João Pedro on 10/06/2023.
//

import SwiftUI
import Kingfisher

struct DetailView: View {
    
    @StateObject var viewModel: DetailsViewModel
    
    var body: some View {
        GeometryReader { proxy in
            ScrollView(showsIndicators: false) {
                DetailsMainView(movie: viewModel.movie)
                    .frame(width: proxy.size.width,
                           height: proxy.size.height)
                
                SinopseView(movie: viewModel.movie, cast: viewModel.cast)
                    .frame(width: proxy.size.width)
            }
        }
        .ignoresSafeArea()
        .task {
            await viewModel.fetchMovieDetails()
        }
        
    }
}

struct DetailsMainView: View {
    
    var movie: Movie?
    
    var body: some View {
        
        GeometryReader { proxy in
            ZStack {
                
                DetailsBackgroundView(movie: movie)
                DetailsMetadataView(movie: movie)
                    .frame(width: proxy.size.width)
            }
            .frame(width: proxy.size.width)
        }
    }
}

struct SinopseView: View {
    
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

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(viewModel: DetailsViewModel(movieService: MovieService(tmdbServices: TMDBServices()), movieID: 1))
        
//        SinopseView()
    }
}
