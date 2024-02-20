//
//  PaintingCell.swift
//  CatalogueOfPaintings
//
//  Created by Vasilii Pronin on 16.02.2024.
//

import UIKit

final class PaintingCell: UICollectionViewCell {
    
    private let borderLayer = CAShapeLayer()
    
    private lazy var paintingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupConstraints()
        layer.addSublayer(borderLayer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupShape(layer: borderLayer, for: bounds)
    }
    
    func configure(with work: Work) {
        paintingImageView.image = UIImage(named: work.image)
    }
    
    private func setupConstraints() {
        addSubview(paintingImageView)
        
        NSLayoutConstraint.activate([
            paintingImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            paintingImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            paintingImageView.topAnchor.constraint(equalTo: topAnchor),
            paintingImageView.widthAnchor.constraint(equalTo: widthAnchor),
            paintingImageView.heightAnchor.constraint(equalTo: paintingImageView.widthAnchor)
        ])
    }
    
    private func setupShape(layer: CAShapeLayer, for rect: CGRect) {
        layer.strokeColor = UIColor.black.cgColor
        layer.lineWidth = 1
        layer.frame = bounds
        layer.fillColor = nil
        layer.path = UIBezierPath(rect: rect).cgPath
        self.layer.addSublayer(layer)
    }
}
