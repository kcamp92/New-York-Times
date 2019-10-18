//
//  NewYorkTimesTests.swift
//  NewYorkTimesTests
//
//  Created by Krystal Campbell on 10/18/19.
//  Copyright © 2019 Krystal Campbell. All rights reserved.
//

import XCTest
@testable import NewYorkTimes

class NewYorkTimesTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    private func nytBookModel() -> Data? {
            let bundle = Bundle(for: type(of: self))
            guard let pathToData = bundle.path(forResource: "NYTtest", ofType: ".json")  else {
                XCTFail("couldn't find Json")
                return nil
            }
            let url = URL(fileURLWithPath: pathToData)
            do {
                let data = try Data(contentsOf: url)
                return data
            } catch let error {
                fatalError("couldn't find data \(error)")
            }
        }

        func testNYTBookModel () {
            let data = nytBookModel() ?? Data()
            let bookdata = BestSellersWrapper.getNYTData(from: data) ?? []
            XCTAssertTrue(bookdata.count > 0, "No book was loaded")
    }
    
    private func googleBookModel() -> Data? {
             let bundle = Bundle(for: type(of: self))
             guard let pathToData = bundle.path(forResource: "googleBooks", ofType: ".json")  else {
                 XCTFail("couldn't find Json")
                 return nil
             }
             let url = URL(fileURLWithPath: pathToData)
             do {
                 let data = try Data(contentsOf: url)
                 return data
             } catch let error {
                 fatalError("couldn't find data \(error)")
             }
         }

         func testgoogleBookModel () {
             let data = googleBookModel() ?? Data()
            let bookdata = BookWrapper.getGoogleBookData(from: data)
            XCTAssertTrue(bookdata != nil, "No book was loaded")
     }
}
