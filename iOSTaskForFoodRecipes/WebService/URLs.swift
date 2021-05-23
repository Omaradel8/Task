//
//  URLs.swift
//  FoodLand
//
//  Created by Omar on 04/01/2021.
//

import Foundation

class URLs {
    static let Instance = URLs()
    private init() {}
    
    func getRecipes() -> String {
        return "https://api.edamam.com/search"
    }
}
