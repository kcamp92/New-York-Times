//
//  GoogleBooks.swift
//  NewYorkTimes
//
//  Created by Michelle Cueva on 10/18/19.
//  Copyright © 2019 Krystal Campbell. All rights reserved.
//

import Foundation
struct BookWrapper: Codable {
    let items: [Items]
  
    static func getGoogleBookData(from data:Data) -> [Items]? {
         do {
            let newbook = try JSONDecoder().decode(BookWrapper.self, from: data)
            return newbook.items
         } catch let error {
             print(error)
             return nil
         }
     }
}

struct Items: Codable {
    let volumeInfo: Books?
    
}

struct Books: Codable {
    let authors: [String]
    let description: String
    let imageLinks: ImageLinks
    let title:String
    func returnAuthors() -> String {
        switch authors.count {
        case 1:
            return authors[0]
        case 2:
            return "\(authors[0]) and \(authors[1])"
        case 3:
            return "\(authors[0]), \(authors[1]) and \(authors[0])"
        default:
            return authors[0]
        }
    }
}
struct ImageLinks: Codable {
    let thumbnail: String
}
