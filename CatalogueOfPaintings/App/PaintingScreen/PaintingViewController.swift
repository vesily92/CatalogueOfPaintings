//
//  PaintingViewController.swift
//  CatalogueOfPaintings
//
//  Created by Vasilii Pronin on 17.02.2024.
//

import UIKit

final class PaintingViewController: UIViewController {
    
    private var paintingScrollView: PaintingScrollView!
    
    init(painting: Work) {
        super.init(nibName: nil, bundle: nil)
        setupScrollView()
        setImage(with: painting)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
    }
    
    private func setImage(with painting: Work) {
        guard let image = UIImage(named: painting.image) else { return }
        paintingScrollView.set(image: image)
    }
    
    private func setupScrollView() {
        paintingScrollView = PaintingScrollView(frame: view.bounds)
        paintingScrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(paintingScrollView)
        
        NSLayoutConstraint.activate([
            paintingScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            paintingScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            paintingScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            paintingScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
