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

struct Recipes:Codable{
//    var description: String {
//        return "Recipe Name: \(title), Recipe URL: \(sourceUrl), Calorie info: \(nutrition)"
//    }
    var title:String
    var sourceUrl:String
    struct Nutrition: Codable {
        struct Nutrients: Codable{
            let amount:Double
            let unit:String
        }
        let nutrients:[Nutrients]
    }
    let nutrition:Nutrition
}
