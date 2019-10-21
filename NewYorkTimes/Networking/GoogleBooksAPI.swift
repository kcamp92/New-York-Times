//
//  WeatherAPIClient.swift
//  Weather App
//
//  Created by Michelle Cueva on 10/13/19.
//  Copyright © 2019 Michelle Cueva. All rights reserved.
//

import Foundation

class GoogleBookAPI {
    static let shared = GoogleBookAPI()
    
    
    
    func getGoogleBookData(book:BestSellers,completionHandler:@escaping(Result<[Items],AppError>)-> Void) {
        var correctUrl = ""
        if book.isbns.count == 0 {
            correctUrl = book.book_details[0].getFormattedTitle()
            print(correctUrl)
        } else {
            correctUrl = "+isbn:\(book.isbns[0].isbn10)"
        }
        
        let url = "https://www.googleapis.com/books/v1/volumes?q=\(correctUrl)&key=AIzaSyBQ_TfDLtpJUwd6ZPumogW6eREP3VW5PKw"
        
        guard let urlStr = URL(string: url) else {
            completionHandler(.failure(.badURL))
            return
        }

        NetworkHelper.manager.performDataTask(withUrl: urlStr, andMethod: .get) { (results) in
            switch results {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let data):
                do {  let bookData = try JSONDecoder().decode(BookWrapper.self, from: data)
                    completionHandler(.success(bookData.items))
                } catch {
                    completionHandler(.failure(.invalidJSONResponse))
                }
        }
    }
}
}
