//
//  NYTCategories.swift
//  NewYorkTimes
//
//  Created by Eric Widjaja on 10/18/19.
//  Copyright © 2019 Krystal Campbell. All rights reserved.
//

import Foundation
struct CategoryWrapper: Codable {
    let results:[Category]
}

struct Category: Codable {
    let list_name_encoded: String
    
}
