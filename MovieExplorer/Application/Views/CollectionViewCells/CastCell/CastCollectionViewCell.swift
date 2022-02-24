//
//  CastCollectionViewCell.swift
//  MovieExplorer
//
//  Created by João Pedro on 24/02/2022.
//

import UIKit
import Kingfisher

class CastCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var castImageView: UIImageView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        castImageView.layer.cornerRadius = castImageView.bounds.width / 2
        castImageView.layer.masksToBounds = true
    }
    
    func setup(cast: Cast?) {
        castImageView.kf.setImage(with: cast?.profileImageURL)
    }
    
}
