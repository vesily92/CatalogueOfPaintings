//
//  ArtistCell.swift
//  CatalogueOfPaintings
//
//  Created by Vasilii Pronin on 16.02.2024.
//

import UIKit

final class ArtistCell: UICollectionViewCell {
    
    private let borderLayer = CAShapeLayer()
    private let nameLabelBoarderLayer = CAShapeLayer()
    
    private lazy var artistImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var artistNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        setupShape(layer: nameLabelBoarderLayer, for: containerView.frame)
    }
    
    func configure(with artist: Artist) {
        artistImageView.image = UIImage(named: artist.image)
        artistNameLabel.text = artist.name
    }
    
    private func setupConstraints() {
        containerView.addSubview(artistNameLabel)
        addSubview(artistImageView)
        addSubview(containerView)
        
        NSLayoutConstraint.activate([
            artistImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            artistImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            artistImageView.topAnchor.constraint(equalTo: topAnchor),
            artistImageView.widthAnchor.constraint(equalTo: widthAnchor),
            artistImageView.heightAnchor.constraint(equalTo: artistImageView.widthAnchor),
            
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.widthAnchor.constraint(equalTo: widthAnchor),
            containerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            artistNameLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            artistNameLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
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
