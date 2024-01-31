//
//  ExerciseDetailDataSourceTests.swift
//  GymondoTests
//
//  Created by Erfan Andesta on 28.01.24.
//

import Foundation
import XCTest
import Combine

@testable import Gymondo

final class ExerciseDetailDataSourceTests: XCTestCase {

    var sut: ExerciseDetailDataSource!
    var imageDataSource = ExerciseImagesDataSource()
    var tableView = UITableView()
    
    override func setUp() {
        super.setUp()
        //Given
        sut = ExerciseDetailDataSource(imagesDataSource: imageDataSource)
        tableView.dataSource = sut
        tableView.register(ExerciseImagesTableViewCell.self, forCellReuseIdentifier: String(describing: ExerciseImagesTableViewCell.self))
    }
    
    func test_default_data() {
        //Then
        XCTAssertTrue(sut.variations.isEmpty)
        XCTAssertEqual(sut.title, "")
        XCTAssertTrue(sut.imagesDataSource.images.isEmpty)
        XCTAssertEqual(sut.numberOfSections(in: tableView), Section.allCases.count)
        XCTAssertEqual(sut.tableView(tableView, numberOfRowsInSection: 0), 1)
        XCTAssertEqual(sut.tableView(tableView, numberOfRowsInSection: 1), 0)
        XCTAssertEqual(sut.tableView(tableView, numberOfRowsInSection: 2), 1)
    }
    
    func test_load_data() {
        //Given
        let pub1 = Result<UIImage?, Error>.Publisher(.success(UIImage()))
            .eraseToAnyPublisher()
        let pub2 = Fail<UIImage?, Error>(error: NSError(domain: "", code: 1))
            .eraseToAnyPublisher()
        
        //When
        sut.setData(title: "test",
                    variations: [1, 2], images: [pub1, pub2])
        
        //Then
        XCTAssertEqual(sut.title, "test")
        XCTAssertEqual(sut.variations, [1, 2])
        XCTAssertEqual(sut.tableView(tableView, numberOfRowsInSection: 1), sut.variations.count)
        XCTAssertEqual(sut.imagesDataSource.images.count, 2)
    }
    
    func test_title_header() {
        let title1 = sut.tableView(tableView, titleForHeaderInSection: 0)
        let title2 = sut.tableView(tableView, titleForHeaderInSection: 1)
        let title3 = sut.tableView(tableView, titleForHeaderInSection: 2)
        
        XCTAssertEqual(Section.allCases.map { $0.rawValue.uppercased() }, [title1, title2, title3])
    }
    
    func test_datasource_cell_setup_name() {
        //Given
        sut.setData(title: "test", variations: [], images: [])
        
        //When
        tableView.reloadData()
        
        //Then
        let cell = sut.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        let content = cell.contentConfiguration as! UIListContentConfiguration
        XCTAssertEqual(content.text, sut.title)
    }
    func test_datasource_cell_setup_variations() {
        //Given
        sut.setData(title: "", variations: [1, 2], images: [])
        
        //When
        tableView.reloadData()
        
        //Then
        let cell1 = sut.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 1))
        let cell2 = sut.tableView(tableView, cellForRowAt: IndexPath(row: 1, section: 1))
        
        let content1 = cell1.contentConfiguration as! UIListContentConfiguration
        XCTAssertEqual(content1.text, "\(sut.variations[0])")
        
        let content2 = cell2.contentConfiguration as! UIListContentConfiguration
        XCTAssertEqual(content2.text, "\(sut.variations[1])")
    }
    
    func test_datasource_cell_setup_images() {
        //Given
        let pub = Result<UIImage?, Error>.Publisher(.success(UIImage()))
            .eraseToAnyPublisher()
        sut.setData(title: "", variations: [], images: [pub, pub])
        
        //When
        tableView.reloadData()
        
        //Then
        let cell = sut.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 2)) as! ExerciseImagesTableViewCell
        XCTAssert(cell.collectionView.dataSource === sut.imagesDataSource)
    }
}


