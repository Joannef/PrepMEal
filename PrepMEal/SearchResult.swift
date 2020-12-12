//
//  SearchResult.swift
//  PrepMEal
//
//  Created by Joanne Fung on 12/10/20.
//

import Foundation

struct Result: Codable {
    var results = [Recipes]()
}

struct Recipes:Codable, CustomStringConvertible {
    var description: String {
        return "Recipe Name: \(title), Recipe URL: \(sourceUrl), Nutrition info: \(nutrition)"
    }
    var title:String
    var sourceUrl:String
    var nutrition:Nutrition
}

struct Nutrition: Codable, CustomStringConvertible {
    var description: String {
        return "\(nutrients)"
    }
    var nutrients:[Nutrients]
}

struct Nutrients: Codable, CustomStringConvertible {
    var description: String {
        return "Calories: \(amount) \(unit)"
    }
    var amount:Double
    var unit:String
}
