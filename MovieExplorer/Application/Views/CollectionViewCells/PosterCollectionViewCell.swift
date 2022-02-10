//
//  PosterCollectionViewCell.swift
//  MovieExplorer
//
//  Created by João Pedro on 10/02/2022.
//

import UIKit

class PosterCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.image = nil
    }
    
    func setup(image: UIImage) {
        posterImageView.image = image
    }
}
