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

   
    func getGenreList() throws -> [Results] {
        return try persistenceHelper.getObjects()
    }
    
    func save(genreList:[Results]) throws {
      try persistenceHelper.saveArray(newElement: genreList)
    }

    private let persistenceHelper = PersistenceHelper<Results>(fileName: "genreList.plist")

    private init() {}
}
