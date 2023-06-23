//
//  TVShowsView.swift
//  MovieExplorer
//
//  Created by João Pedro on 15/06/2023.
//

import SwiftUI
import Kingfisher

struct TVShowsView: View {
    
    @StateObject var viewModel: TVShowsViewModel
    
    var body: some View {
        GeometryReader { proxy in
            TabView {
                ForEach(viewModel.tvShows) { show in
                    ZStack {
                        
                        KFImage(show.getPosterURL(with: .medium))
                            .resizable()
                            .ignoresSafeArea()
                            .scaledToFill()
                        
                        LinearGradient(colors: [.clear, .black.opacity(0.6)],
                                       startPoint: .init(x: 0.0, y: 0.8),
                                       endPoint: .init(x: 0.0, y: 1.0))
                    }
                }
            }
            .task {
                await viewModel.fetchPopularTVShows()
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
        }
    }
}

struct TVShowsView_Previews: PreviewProvider {
    static var previews: some View {
        TVShowsView(viewModel: TVShowsViewModel(tvShowsService: TVShowsService(tmdbServices: TMDBServices())))
    }
}
