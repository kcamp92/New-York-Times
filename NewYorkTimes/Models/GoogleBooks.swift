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
}

struct Items: Codable {
    let volumeInfo: Books?
}

struct Books: Codable {
    let authors: [String]
    let description: String
    let imageLinks: ImageLinks
    
}
struct ImageLinks: Codable {
    let thumbnail: String
}
