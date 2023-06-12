//
//  UIView+Extensions.swift
//  MovieExplorer
//
//  Created by João Pedro on 06/06/2023.
//

import UIKit

extension UIView {
    // MARK: - Constraints
    /// Applies width, height, center Y and center X anchor constraints to match a given UIView.
    func constraintsToFillSuperview(_ view: UIView) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalTo: view.widthAnchor),
            heightAnchor.constraint(equalTo: view.heightAnchor),
            centerXAnchor.constraint(equalTo: view.centerXAnchor),
            centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
