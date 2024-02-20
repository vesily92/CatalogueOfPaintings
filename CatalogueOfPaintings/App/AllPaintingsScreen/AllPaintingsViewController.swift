//
//  AllPaintingsViewController.swift
//  CatalogueOfPaintings
//
//  Created by Vasilii Pronin on 16.02.2024.
//

import UIKit

final class AllPaintingsViewController: UIViewController {
    
    weak var coordinator: ICoordinator?
    
    private typealias DataSource = UICollectionViewDiffableDataSource<Int, Work>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Work>
    
    private var collectionView: UICollectionView!
    private var dataSource: DataSource!
    
    private let artist: Artist
    
    init(artist: Artist) {
        self.artist = artist
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        createDataSource()
        
        dataSource?.apply(createSnapshot())
    }
    
    // MARK: - Private methods
    
    private func setupCollectionView() {
        collectionView = UICollectionView(
            frame: view.bounds,
            collectionViewLayout: createLayout()
        )
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.register(
            PaintingCell.self,
            forCellWithReuseIdentifier: PaintingCell.reuseIdentifier
        )
        
        view.addSubview(collectionView)
    }
    
    // MARK: CollectionView Layout
    
    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1 / 2),
            heightDimension: .fractionalHeight(1)
        )
        
        let item = NSCollectionLayoutItem(
            layoutSize: itemSize
        )
        item.contentInsets = .init(top: 4, leading: 4, bottom: 4, trailing: 4)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalWidth(1 / 2)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group)
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    // MARK: CollectionView DataSource
    
    private func createDataSource() {
        dataSource = DataSource(
            collectionView: collectionView
        ) { collectionView, indexPath, painting in
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PaintingCell.reuseIdentifier,
                for: indexPath
            ) as? PaintingCell else {
                return UICollectionViewCell()
            }
            
            cell.configure(with: painting)
            
            return cell
        }
    }
    
    private func createSnapshot() -> Snapshot {
        var snapshot = Snapshot()
        snapshot.appendSections([1])
        snapshot.appendItems(artist.works)
        return snapshot
    }
}

extension AllPaintingsViewController: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        coordinator?.showPainting(with: artist.works[indexPath.item])
    }
}

