//
//  CatagoryPersistenceHelper.swift
//  NewYorkTimes
//
//  Created by Phoenix McKnight on 10/19/19.
//  Copyright © 2019 Krystal Campbell. All rights reserved.
//

import Foundation

struct GenrePersistenceManager  {
    static let manager = GenrePersistenceManager()

   
    func getGenreList() throws -> [Categories] {
        return try persistenceHelper.getObjects()
    }
    
    func save(genreList:[Categories]) throws {
      try persistenceHelper.saveArray(newElement: genreList)
    }

    private let persistenceHelper = PersistenceHelper<Categories>(fileName: "genreList.plist")

    private init() {}
}
