//
//  NYTimes.swift
//  NewYorkTimes
//
//  Created by Michelle Cueva on 10/18/19.
//  Copyright © 2019 Krystal Campbell. All rights reserved.
//

import Foundation
struct BestSellersWrapper: Codable {
    let results: [BestSellers]
}

struct BestSellers: Codable {
    let weeks_on_list: Int
    let isbns: [Isbn]
    let book_details: [BookDetails]
}

struct Isbn: Codable {
    let isbn10: String
    let isbn13: String
    
}
struct BookDetails: Codable {
    let description: String
}

