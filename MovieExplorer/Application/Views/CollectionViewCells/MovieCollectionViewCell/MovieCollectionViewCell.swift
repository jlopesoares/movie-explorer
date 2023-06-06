//
//  MovieCollectionViewCell.swift
//  MovieExplorer
//
//  Created by João Pedro on 06/06/2023.
//

import UIKit
import SwiftUI

class MovieCollectionViewCell: UICollectionViewCell {
    
    var movieCellView: UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config(movie: Movie) {
        
        guard let movieCellView else {
            
            let movieCellViewHostingController = UIHostingController(rootView: MovieCellView())

            let movieCellView = movieCellViewHostingController.view
            movieCellView?.backgroundColor = .clear
            movieCellView!.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(movieCellView!)

            NSLayoutConstraint.activate([
                movieCellView!.topAnchor.constraint(equalTo: contentView.topAnchor),
                movieCellView!.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                movieCellView!.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                movieCellView!.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
             ])

            self.movieCellView = movieCellView
            
            return
        }
    
        
        print("do some config here")
        
    }
}
