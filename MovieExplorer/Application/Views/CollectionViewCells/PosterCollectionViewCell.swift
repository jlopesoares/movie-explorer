//
//  PosterCollectionViewCell.swift
//  MovieExplorer
//
//  Created by João Pedro on 10/02/2022.
//

import UIKit
import Kingfisher

class PosterCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var posterImageView: UIImageView! {
        didSet {
            posterImageView.layer.cornerRadius = 12.0
            posterImageView.layer.masksToBounds = true
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.image = nil
    }
    
    func setup(movie: Movie) {
        
        guard
            let backdrop = movie.backdropURL,
            let backdropURL = movie.getImageUrl(for: backdrop.absoluteString, with: .small)
        else {
            return
        }
        posterImageView.kf.setImage(with: backdropURL)
    }
}
