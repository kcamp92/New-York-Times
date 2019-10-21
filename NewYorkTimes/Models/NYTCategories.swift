//
//  NYTCategories.swift
//  NewYorkTimes
//
//  Created by Eric Widjaja on 10/18/19.
//  Copyright © 2019 Krystal Campbell. All rights reserved.
//

import Foundation

// MARK: - Books
struct CategoryWrapper: Codable {
    
    let results: [Categories]
    static func getGenreData(from data:Data) -> [Categories]? {
           do {
               let genres = try JSONDecoder().decode(CategoryWrapper.self, from: data)
               return genres.results
           } catch let error {
               print(error)
               return nil
           }
       }
}

// MARK: - Result
struct Categories: Codable {
    let  displayName: String
    let listName:String

    enum CodingKeys: String, CodingKey {
        case displayName = "display_name"
       case listName = "list_name_encoded"
    }
}
