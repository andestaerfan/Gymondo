//
//  CustomJSONDecoderTests.swift
//  GymondoTests
//
//  Created by Erfan Andesta on 26.01.24.
//

import XCTest
@testable import Gymondo

final class CustomJSONDecoderTests: XCTestCase {
    
    var sut: CustomJSONDecoder!
    
    func test_decode_success() throws {
        //Given
        sut = CustomJSONDecoder()
        let url = Bundle(for: type(of: self)).url(forResource: "MockData", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        //When Then
        XCTAssertNoThrow(try sut.decode(MockExercise.self, from: data), "date or snake case failed to decode")
    }
    func test_decode_fail() throws {
        //Given
        sut = CustomJSONDecoder(dateDecodingStrategy: .deferredToDate)
        let url = Bundle(for: type(of: self)).url(forResource: "MockData", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        //When Then
        XCTAssertThrowsError(try sut.decode(MockExercise.self, from: data), "It should fail")
    }
}
