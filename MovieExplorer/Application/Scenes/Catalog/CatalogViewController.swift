//
//  CatalogViewController.swift
//  MovieExplorer
//
//  Created by João Pedro on 09/02/2022.
//

import UIKit

class CatalogViewController: UIViewController {

    weak var catalogCoordinator: DetailCoordinateFlow!
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            let posterCollectionCell = String(describing: PosterCollectionViewCell.self)
            collectionView.register(UINib(nibName: posterCollectionCell, bundle: .main), forCellWithReuseIdentifier: posterCollectionCell)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

//MARK: - Collection Datasource
extension CatalogViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        .init(frame: .zero)
    }
    
}
