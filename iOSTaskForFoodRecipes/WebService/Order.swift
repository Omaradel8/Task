//
//  Order.swift
//  iOSTaskForFoodRecipes
//
//  Created by Omar on 22/05/2021.
//

import Foundation

enum CoffeType: String, Codable {
    case cappuccino
    case latte
    case espressino
    case cortado
}

enum CoffeSize: String, Codable {
    case small
    case medium
    case large
}

struct Order: Codable {
    let name: String
    let email: String
    let type: CoffeType
    let size: CoffeSize
}

// MARK: - PrivacyPoliceModel
struct PrivacyPoliceModel: Codable {
    var msg: String?
    var statusCode: Int?
    var success: Bool?
    var payload: String?
}
