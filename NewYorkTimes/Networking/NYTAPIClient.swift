//
//  CityAPIHelper.swift
//  Weather App
//
//  Created by Michelle Cueva on 10/17/19.
//  Copyright © 2019 Michelle Cueva. All rights reserved.
//

import Foundation

import UIKit

class NYTAPIClient {
    static let shared = NYTAPIClient()
    
    func getBestSellerList(genre:String,completionHandler:@escaping(Result<[BestSellers],AppError>)-> Void) {
        
        let url = "https://api.nytimes.com/svc/books/v3/lists.json?api-key=\(Secrets.nytAuthorBestSeller)&list=\(genre)"
        guard let urlStr = URL(string: url) else {
            completionHandler(.failure(.badURL))
            return
        }
        NetworkHelper.manager.performDataTask(withUrl: urlStr, andMethod: .get) { (results) in
            switch results {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let data):
                do {
                   let bookData = try JSONDecoder().decode(BestSellersWrapper.self, from: data)
                    completionHandler(.success(bookData.results.sorted(by: {$0.weeks_on_list < $1.weeks_on_list})))
                } catch {
                completionHandler(.failure(.invalidJSONResponse))
            }
        }
    }
}
}
