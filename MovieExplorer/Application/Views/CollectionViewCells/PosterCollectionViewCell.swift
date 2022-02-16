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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.image = nil
    }
    
    func setup(movie: Movie) {
        posterImageView.kf.setImage(with: movie.backdropURL.absoluteURL)
    }
}
