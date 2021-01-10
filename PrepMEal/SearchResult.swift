//
//  SearchResult.swift
//  PrepMEal
//
//

import Foundation

struct Result: Codable {
    var results = [Recipes]()
}

struct Recipes: Codable{
//    var description: String {
//        return "Recipe Name: \(title), Recipe URL: \(sourceUrl), Calorie info: \(nutrition)"
//    }
    var title:String
    var sourceUrl:String
    var image:String
    struct Nutrition: Codable {
        struct Nutrients: Codable{
            let amount:Double
            let unit:String
        }
        let nutrients:[Nutrients]
    }
    let nutrition:Nutrition
}
