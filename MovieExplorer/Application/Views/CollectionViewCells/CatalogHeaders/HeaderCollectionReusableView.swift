//
//  HeaderCollectionReusableView.swift
//  MovieExplorer
//
//  Created by João Pedro on 18/02/2022.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var headerButton: UIButton!
    
    func setup(with rail: Rail) {
        titleLabel.text = rail.name
        headerButton.setTitle("Ver todos", for: .normal)
    }
}
