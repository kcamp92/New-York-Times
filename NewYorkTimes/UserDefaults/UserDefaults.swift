//
//  UserDefaults.swift
//  NewYorkTimes
//
//  Created by Michelle Cueva on 10/18/19.
//  Copyright © 2019 Krystal Campbell. All rights reserved.
//

import Foundation
struct UserDefaultsWrapper {
    static let shared = UserDefaultsWrapper()
    private let listedCurrentGenre = "listedCurrentGenre"
    private let currentRow = "currentRow"
    private let displayCurrentGenre = "displayCurrentGenre"
    
    func store(listGenre:String) {
        UserDefaults.standard.set(listGenre, forKey: listedCurrentGenre)
    }
    
    func store(rowOfPickedGenre:Int) {
        UserDefaults.standard.set(rowOfPickedGenre, forKey: currentRow)
    }
    func getCurrentRow() -> Int? {
        UserDefaults.standard.value(forKey: currentRow) as? Int
    }
    
    func getListedGenre() -> String? {
        UserDefaults.standard.value(forKey: listedCurrentGenre) as? String
    }
    func store(displayNameGenre:String) {
        UserDefaults.standard.set(displayNameGenre, forKey: displayCurrentGenre)
    }
    func getDisplayGenre() -> String? {
        UserDefaults.standard.value(forKey: displayCurrentGenre) as? String
    }
}
