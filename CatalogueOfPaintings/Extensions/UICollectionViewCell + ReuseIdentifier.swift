//
//  UICollectionViewCell + ReuseIdentifier.swift
//  CatalogueOfPaintings
//
//  Created by Vasilii Pronin on 16.02.2024.
//

import UIKit

extension UICollectionViewCell {
    
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}
