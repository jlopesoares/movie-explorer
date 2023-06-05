//
//  DetailedMovieCollectionViewCell.swift
//  MovieExplorer
//
//  Created by João Pedro on 14/02/2022.
//

import UIKit
import Kingfisher

class DetailedMovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var movieBackgroundImageView: UIImageView! {
        didSet {
            movieBackgroundImageView.layer.cornerRadius = 10
            movieBackgroundImageView.layer.masksToBounds = true
        }
    }
    
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sinopseLabel: UILabel!
    
    func setup(movie: Movie) {
        
        genderLabel.text = "Drama".uppercased()
        titleLabel.text = movie.title
        sinopseLabel.text = movie.overview
        
        guard
            let backdrop = movie.backdropURL,
            let backdropURL = movie.getImageUrl(for: backdrop.absoluteString, with: .small)
        else {
            return
        }
        
        movieBackgroundImageView.kf.setImage(with: backdropURL)
    }

}
