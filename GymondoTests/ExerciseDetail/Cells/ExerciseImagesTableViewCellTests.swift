//
//  ExerciseImagesTableViewCellTests.swift
//  GymondoTests
//
//  Created by Erfan Andesta on 28.01.24.
//

import XCTest
@testable import Gymondo

final class ExerciseImagesTableViewCellTests: XCTestCase {

    var sut: ExerciseImagesTableViewCell!
    
    func test_subviews() {
        sut = ExerciseImagesTableViewCell(frame: .zero)
        XCTAssertEqual(sut.subviews.count, 1)
        XCTAssertNotNil(sut.subviews[0] as? UICollectionView)
    }
    func test_set_dataSource() {
        sut = ExerciseImagesTableViewCell(frame: .zero)
        let dataSource = ExerciseImagesDataSource()
        sut.set(dataSource: dataSource)
        XCTAssertTrue(sut.collectionView.dataSource === dataSource)
        XCTAssertTrue(sut.collectionView.delegate === sut)
    }
}
