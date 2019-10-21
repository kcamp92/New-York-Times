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
    
    static func getNYTData(from data:Data) -> [BestSellers]? {
        do {
            let newbook = try JSONDecoder().decode(BestSellersWrapper.self, from: data)
            return newbook.results
        } catch let error {
            print(error)
            return nil
        }
    }
}

struct BestSellers: Codable {
    let weeks_on_list: Int
    let isbns: [Isbn]
    let book_details: [BookDetails]
    let amazon_product_url:String
    
    
    func returnWeeksOnlistAsString(weeks:Int) -> String {
        switch weeks {
        case 0:
            return "First week on the best seller list"
        case 1:
            return "\(weeks) week on the best seller list"
        default:
            return " \(weeks) weeks on the best seller list"
        }
    }
}

struct Isbn: Codable {
    let isbn10: String
    let isbn13: String
    
}
struct BookDetails: Codable {
    let description: String
    let title: String
    
    func getFormattedTitle() -> String {
        return title.replacingOccurrences(of: " ", with: "-")
    }
}

