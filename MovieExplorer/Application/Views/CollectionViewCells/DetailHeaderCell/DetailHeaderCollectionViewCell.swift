//
//  DetailHeaderCollectionViewCell.swift
//  MovieExplorer
//
//  Created by João Pedro on 23/02/2022.
//

import UIKit
import Kingfisher

class DetailHeaderCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var disclaimerLabel: UILabel!
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mainActionButton: UIButton!
    
    func setup(movie: Movie) {
        disclaimerLabel.text = "Novos episódios todas as semanas"
        
        titleLabel.text = movie.title
        
        headerImageView.kf.setImage(with: movie.backdropOriginalURL.absoluteURL)
    }
}
