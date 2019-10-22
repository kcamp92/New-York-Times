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
                  return "NEW THIS WEEK"
              case 1:
                  return "\(weeks) WEEK ON THE LIST"
              default:
                  return " \(weeks) WEEKS ON THE LIST"
              }
    }
    
    func getReviewUrl() -> String {
        let link = amazon_product_url

        let arr1 = link.components(separatedBy: "?")

        let arr2 = arr1[0].components(separatedBy: "/")
        
        guard let key = arr2.last else {return link}
        return "https://www.amazon.com/review/create-review/?ie=UTF8&channel=glance-detail&asin=\(key)"
       
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

