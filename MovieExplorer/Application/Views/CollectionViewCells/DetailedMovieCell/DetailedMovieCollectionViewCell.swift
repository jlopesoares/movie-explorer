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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(movie: Movie) {
        
        movieBackgroundImageView.kf.setImage(with: movie.backdropURL.absoluteURL)
        
        genderLabel.text = "Drama".uppercased()
        titleLabel.text = movie.title
        sinopseLabel.text = movie.overview
    }

}
