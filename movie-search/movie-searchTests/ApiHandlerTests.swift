//
//  ApiHandlerTests.swift
//  movie-searchTests
//
//  Created by Carlos Arenas on 3/12/18.
//  Copyright © 2018 Carlos Arenas. All rights reserved.
//

import XCTest
@testable import movie_search

class ApiHandlerTests: XCTestCase {
    
    var movieSearchTests: ApiHandler!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        movieSearchTests = ApiHandler()
//        movieSearchTests.performSearch(for: <#T##String#>, completion: <#T##(MovieData?) -> Void#>)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
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
    
}
