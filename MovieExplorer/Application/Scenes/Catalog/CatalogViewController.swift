//
//  CatalogViewController.swift
//  MovieExplorer
//
//  Created by João Pedro on 09/02/2022.
//

import UIKit

class CatalogViewController: UIViewController {

    weak var catalogCoordinator: DetailCoordinateFlow!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Test"
    }
    
    @IBAction func openDetail(_ sender: Any) {
        
        catalogCoordinator.coordinateToDetail()
    }
}
