//
//  SearchViewController.swift
//  MovieExplorer
//
//  Created by João Pedro Soares on 27/07/2023.
//

import UIKit

class SearchViewController: UIViewController {

    //Outlets
    @IBOutlet weak var collectionView: CatalogCollectionView! {
        didSet {
            collectionView.registerCells()
            collectionView.delegate = self
            collectionView.updateCatalogType(.grids)
            collectionView.keyboardDismissMode = .onDrag
            collectionDataSource = collectionView.setupCollectionProvider(container: self)
        }
    }
    
    var textfield: UITextField!
    
    //Vars
    var viewModel: SearchViewModel!
    var coordinator: SearchCoordinator!
    var collectionDataSource: UICollectionViewDiffableDataSource<Rail, AnyHashable>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI() {
        textfield = UITextField(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 30))
        textfield.borderStyle = .roundedRect
        textfield.delegate = self
        textfield.returnKeyType = .search
        textfield.becomeFirstResponder()
        navigationItem.titleView = textfield
        
        collectionView.backgroundColor = .mainBackgroundColor
    }
    
    func updateCollectionView() {
        
        var snapshot = NSDiffableDataSourceSnapshot<Rail, AnyHashable>()
        snapshot.appendSections(viewModel.datasource)

        for rail in viewModel.datasource {
            snapshot.appendItems(rail.type.values, toSection: rail)
        }

        collectionDataSource.apply(snapshot, animatingDifferences: true, completion: nil)
    }
}

//MARK: - Collection Delegation
extension SearchViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let item = viewModel.item(for: indexPath)

        switch item {
        case let item as Movie:
            coordinator.coordinateToDetail(with: item.movieID)
        case let item as MovieProvider:
            break
        default:
            break
        }
    }
}

//MARK: - Collection Delegation
extension SearchViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        Task {
            await self.viewModel.search(term: self.textfield.text ?? "")
            self.updateCollectionView()
        }
        
        return true
    }
}
