//
//  PhotoPersistence.swift
//  Weather App
//
//  Created by Michelle Cueva on 10/17/19.
//  Copyright © 2019 Michelle Cueva. All rights reserved.
//

import Foundation

struct BookPersistenceManager {
    static let manager = BookPersistenceManager()

    func save(newBook: FavoritesModel) throws {
        try persistenceHelper.save(newElement: newBook)
    }

    func getFavoriteBook() throws -> [FavoritesModel] {
       
        return try persistenceHelper.getObjects().sorted(by: {$0.authorName < $1.authorName})
    }
    
    func deleteFavoriteBook(description:String) throws {
        do {
            let newBooksElement = try getFavoriteBook().filter({$0.description != description})
            try persistenceHelper.replace(elements: newBooksElement)
        
        } catch {
            print(error)
        }
    }

    private let persistenceHelper = PersistenceHelper<FavoritesModel>(fileName: "book.plist")

    private init() {}
}
