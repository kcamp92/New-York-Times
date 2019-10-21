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
    
    func getGoogleBookData(isbn10:String,completionHandler:@escaping(Result<[Items],AppError>)-> Void) {
        let url = "https://www.googleapis.com/books/v1/volumes?q=+isbn:\(isbn10)&key=AIzaSyBQ_TfDLtpJUwd6ZPumogW6eREP3VW5PKw"
        
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
