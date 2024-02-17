//
//  Artists.swift
//  CatalogueOfPaintings
//
//  Created by Vasilii Pronin on 16.02.2024.
//

import Foundation

struct Artist: Decodable, Hashable {
    let name: String
    let bio: String
    let image: String
    let works: [Work]
}

struct Work: Decodable, Hashable {
    let title: String
    let image: String
    let info: String
}
