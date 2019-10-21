//
//  GenreListAPI.swift
//  NewYorkTimes
//
//  Created by Phoenix McKnight on 10/18/19.
//  Copyright © 2019 Krystal Campbell. All rights reserved.
//

import Foundation

class GenreListAPIClient {
    static let shared = GenreListAPIClient()
    
    func getGenreList(completionHandler:@escaping(Result<[Results],AppError>)-> Void) {
        
        let url = "https://api.nytimes.com/svc/books/v3/lists/names.json?api-key=\(Secrets.nytAuthorBestSeller)"
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
                    let genreData = try JSONDecoder().decode(CategoryWrapper.self, from: data)
                    completionHandler(.success(genreData.results))
                } catch {
                    completionHandler(.failure(.invalidJSONResponse))
                }
                
            }
        }

}
}
