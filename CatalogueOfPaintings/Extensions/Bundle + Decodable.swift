//
//  Bundle + Decodable.swift
//  CatalogueOfPaintings
//
//  Created by Vasilii Pronin on 16.02.2024.
//

import Foundation

extension Bundle {
    func decode<x: Decodable>(_ type: x.Type, from filename: String) -> x {
        guard let json = url(forResource: filename, withExtension: nil) else {
            fatalError("Failed to locate \(filename) in bundle.")
        }
        do {
            let jsonData = try Data(contentsOf: json)
            let decoder = JSONDecoder()
            let result = try decoder.decode(x.self, from: jsonData)
            return result
        } catch {
            print("Failed to load and decode JSON with error: \(error)")
        }
        
        fatalError("Failed to decode from bundle.")
    }
}
