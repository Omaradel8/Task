//
//  RecipesModel.swift
//  iOSTaskForFoodRecipes
//
//  Created by Omar on 23/05/2021.
//

import Foundation

// MARK: - RecipesResultModel
struct RecipesResultModel: Codable {
    var q: String?
    var from, to: Int?
    var more: Bool?
    var count: Int?
    var hits: [Hit]?
    
    static func getRecipesResult(q: String, callBack: @escaping (Result<RecipesResultModel, NetworkError>) -> Void) {
        let parameters: [URLQueryItem] = [
            URLQueryItem(name: "q", value: q),
            URLQueryItem(name: "app_id", value: app_id),
            URLQueryItem(name: "app_key", value: app_key)
        ]
        WebService().load(url: URLs.Instance.getRecipes(), parameters: parameters, completion: callBack)
    }
}

// MARK: - Hit
struct Hit: Codable {
    var recipe: Recipe?
}

// MARK: - Recipe
struct Recipe: Codable {
    var uri: String?
    var label: String?
    var image: String?
    var source: String?
    var url: String?
    var shareAs: String?
    var yield: Int?
    var dietLabels, healthLabels: [String]?
    var cautions: [Caution]?
    var ingredientLines: [String]?
    var ingredients: [Ingredient]?
    var calories, totalWeight: Double?
    var totalTime: Int?
    var cuisineType, mealType, dishType: [String]?
    var totalNutrients, totalDaily: [String: Total]?
    var digest: [Digest]?
}

enum Caution: String, Codable {
    case fodmap = "FODMAP"
    case sulfites = "Sulfites"
}

// MARK: - Digest
struct Digest: Codable {
    var label, tag: String?
    var schemaOrgTag: String?
    var total: Double?
    var hasRDI: Bool?
    var daily: Double?
    var unit: String?
    var sub: [Digest]?
}

// MARK: - Ingredient
struct Ingredient: Codable {
    var text: String?
    var weight: Double?
    var foodCategory, foodID: String?
    var image: String?

    enum CodingKeys: String, CodingKey {
        case text, weight, foodCategory
        case foodID = "foodId"
        case image
    }
}

// MARK: - Total
struct Total: Codable {
    var label: String?
    var quantity: Double?
    var unit: String?
}
