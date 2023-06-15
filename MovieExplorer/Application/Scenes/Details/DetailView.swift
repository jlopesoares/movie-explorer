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
                
                DetailsSinopseView(movie: viewModel.movie,
                                   cast: viewModel.cast)
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

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(viewModel: DetailsViewModel(movieService: MovieService(tmdbServices: TMDBServices()), movieID: 1))
    
    }
}
