//
//  ProviderCollectionViewCell.swift
//  MovieExplorer
//
//  Created by João Pedro on 06/06/2023.
//

import UIKit
import SwiftUI

class ProviderCollectionViewCell: UICollectionViewCell {
    
    var host: UIHostingController<ProviderCellView>?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - HostingController
    func embed(in parent: UIViewController, with provider: MovieProvider) {
        
        if let host = host {
            host.rootView = ProviderCellView(movieProvider: provider)
            host.view.layoutIfNeeded()
            
        } else {
            
            let host = UIHostingController(rootView: ProviderCellView(movieProvider: provider))
            parent.addChild(host)
            host.didMove(toParent: parent)
            host.view.backgroundColor = .clear
            contentView.addSubview(host.view!)
            host.view.constraintsToFillSuperview(contentView)
            self.host = host
        }
    }
    
    deinit {
        host?.willMove(toParent: nil)
        host?.view?.removeFromSuperview()
        host?.removeFromParent()
        print("Cell has been cleaned")
    }
}


