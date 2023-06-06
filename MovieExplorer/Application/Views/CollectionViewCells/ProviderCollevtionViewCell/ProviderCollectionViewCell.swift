//
//  ProviderCollectionViewCell.swift
//  MovieExplorer
//
//  Created by João Pedro on 06/06/2023.
//

import UIKit
import SwiftUI

class ProviderCollectionViewCell: UICollectionViewCell {
    
    var movieCellView: UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        guard let movieCellView else {
            
            let movieCellViewHostingController = UIHostingController(rootView: ProviderCellView())
            
            let movieCellView = movieCellViewHostingController.view
            contentView.addSubview(movieCellView!)
            movieCellView?.backgroundColor = .clear
            movieCellView?.constraintsToFillSuperview(contentView)
            
            self.movieCellView = movieCellView
            
            return
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config(movie: MovieProvider) {
        
        guard let movieCellView else {
            return
        }
    
        
        print("do some config here")
        
    }
}
