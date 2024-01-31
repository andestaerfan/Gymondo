//
//  ExerciseImagesDataSourceTests.swift
//  GymondoTests
//
//  Created by Erfan Andesta on 28.01.24.
//

import XCTest
import Combine
@testable import Gymondo

final class ExerciseImagesDataSourceTests: XCTestCase {

    var sut: ExerciseImagesDataSource!
    var collectionView: UICollectionView!
    
    override func setUp() {
        super.setUp()
        //Given
        sut = ExerciseImagesDataSource()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.dataSource = sut
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: ImageCollectionViewCell.self))
    }
    
    func test_default_data() {
        //When
        collectionView.reloadData()
        
        //Then
        XCTAssertEqual(collectionView.numberOfSections, 1)
        XCTAssertEqual(collectionView.numberOfItems(inSection: 0), 0)
        XCTAssertEqual(sut.images.count, 0)
    }
    
    func test_datasource_data_load() {
        //Given
        let pub = Result<UIImage?, Error>.Publisher(.success(UIImage()))
            .eraseToAnyPublisher()
        sut.images = [pub, pub]
        
        //When
        collectionView.reloadData()
        
        //Then
        XCTAssertEqual(collectionView.numberOfSections, 1)
        XCTAssertEqual(collectionView.numberOfItems(inSection: 0), sut.images.count)
    }
    
    func test_datasource_cell_setup() {
        //Given
        let pub = Result<UIImage?, Error>.Publisher(.success(UIImage()))
            .eraseToAnyPublisher()
        sut.images = [pub, pub]
        
        //When
        collectionView.reloadData()
        
        //Then
        let cell = sut.collectionView(collectionView, cellForItemAt: IndexPath(item: 0, section: 0)) as! ImageCollectionViewCell
        XCTAssertNotNil(cell.cancellable)
        
        let cell2 = sut.collectionView(collectionView, cellForItemAt: IndexPath(item: 1, section: 0)) as! ImageCollectionViewCell
        XCTAssertNotNil(cell2.cancellable)
    }

}
