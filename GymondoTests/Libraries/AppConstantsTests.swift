//
//  AppConstantsTests.swift
//  GymondoTests
//
//  Created by Erfan Andesta on 29.01.24.
//

import XCTest
@testable import Gymondo

final class AppConstantsTests: XCTestCase {

    var sut = AppConstants.self
    
    func test_all_constants() {
        XCTAssertEqual(sut.APIConstants.baseAPI, "https://wger.de/api/v2")
        XCTAssertEqual(sut.APIConstants.exercises, "exercise")
        XCTAssertEqual(sut.APIConstants.exerciseImageUrlPath, "exerciseimage")
        XCTAssertEqual(sut.APIConstants.exerciseInfoPath, "exerciseinfo")
    }
}
