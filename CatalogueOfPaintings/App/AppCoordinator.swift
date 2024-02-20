//
//  AppCoordinator.swift
//  CatalogueOfPaintings
//
//  Created by Vasilii Pronin on 16.02.2024.
//

import UIKit

protocol ICoordinator: AnyObject {
    
    func start()
    func showAllPaintingsScreen(with artist: Artist)
    func showPainting(with painting: Work)
}

final class AppCoordinator: ICoordinator {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showArtistsScreen()
    }
    
    func showAllPaintingsScreen(with artist: Artist) {
        let allPaintingsVC = AllPaintingsViewController(artist: artist)
        allPaintingsVC.coordinator = self
        navigationController.pushViewController(allPaintingsVC, animated: true)
    }
    
    func showPainting(with painting: Work) {
        let paintingVC = PaintingViewController(painting: painting)
        navigationController.pushViewController(paintingVC, animated: true)
    }
    
    private func showArtistsScreen() {
        let artistsVC = ArtistsViewController()
        artistsVC.coordinator = self
        navigationController.setViewControllers([artistsVC], animated: false)
    }
    
    
}
