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
        
        guard let movieCellView else {
            
            let movieCellViewHostingController = UIHostingController(rootView: MovieCellView())

            let movieCellView = movieCellViewHostingController.view
            movieCellView?.backgroundColor = .clear
            contentView.addSubview(movieCellView!)
            movieCellView?.constraintsToFillSuperview(contentView)

            self.movieCellView = movieCellView
            
            return
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config(movie: Movie) {
        
    
        print("do some config here")
        
    }
}
