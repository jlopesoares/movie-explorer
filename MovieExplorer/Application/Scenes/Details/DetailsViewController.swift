//
//  DetailsViewController.swift
//  MovieExplorer
//
//  Created by João Pedro on 09/02/2022.
//

import UIKit

class DetailsViewController: UIViewController {

    weak var coordinator: DetailsCoordinator!
    var viewModel: DetailsViewModel!
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.collectionViewLayout = createDetailsCompositionalLayout()
            
            collectionView.register(
                UINib(nibName: "HeaderCollectionReusableView", bundle: .main),
                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerCollectionReausableView")
            
        }
    }
    
    var collectionDataSource: UICollectionViewDiffableDataSource<DetailSections, AnyHashable>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionProvider()
        
        Task {
            await getMovieDetail()
        }
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.getMovieCast()
        }
        
    }
    
    func getMovieDetail() async {

        switch await viewModel.fetchMovieDetails() {
        case .success:
            self.updateCollectionView()
        case .failure(let error):
            break
        }
    }
    
    func getMovieCast() {

        viewModel.fetchMovieCast { result in
            switch result {
                case .success(_):
                    self.updateCollectionView()
                case .failure(_):
                    break
            }
        }
    }
    
    func updateCollectionView() {
        
        var snapshot = NSDiffableDataSourceSnapshot<DetailSections, AnyHashable>()
        
        snapshot.appendSections([.header, .cast])
        snapshot.appendItems(viewModel.datasource(for: .header), toSection: .header)
        snapshot.appendItems(viewModel.datasource(for: .cast), toSection: .cast)
        
        collectionDataSource.apply(snapshot, animatingDifferences: true, completion: nil)
    }
    
    func detailedSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
    }
    
    func setupCollectionProvider() {
        
        collectionDataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            
            
            var collectionViewCell = UICollectionViewCell()
            
            switch item {
                    
                case let item as Movie:
                    
                    let detailedCell = collectionView.dequeueReusableCell(withReuseIdentifier: "detailHeaderCell", for: indexPath) as! DetailHeaderCollectionViewCell
                    
                    detailedCell.setup(movie: item)
                    
                    collectionViewCell = detailedCell
                    
                case let item as Cast:
                break
                default:
                    break
            }
            
            return collectionViewCell
            
        })
        
        collectionDataSource.supplementaryViewProvider = { (collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView in
        
            if kind == UICollectionView.elementKindSectionHeader {
                
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerCollectionReausableView", for: indexPath) as! HeaderCollectionReusableView
                
                header.titleLabel.text = "Cast"
                
                return header
            }
            
            return UICollectionReusableView()
        }
        
    }
    
    func createDetailsCompositionalLayout() -> UICollectionViewCompositionalLayout {
        
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            
            switch sectionNumber {
                case 0:
                    return self.nowPopularSection()
                default:
                    return self.castSection()
            }
        }
    }
    
    func nowPopularSection() -> NSCollectionLayoutSection {
        //1
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        //2
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalHeight(0.7))
        
        //3
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)

        section.interGroupSpacing = .zero
        return section
    }
    
    func castSection() -> NSCollectionLayoutSection {
        //1
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(150), heightDimension: .absolute(150))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 0)
        //2
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(150),
                                               heightDimension: .absolute(150))
        
        //3
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 0, bottom: 0, trailing: 0)
        section.boundarySupplementaryItems = [detailedSectionHeader()]
        section.interGroupSpacing = .zero
        
        return section
    }
    
}
