//
//  ExerciseDetailTableViewControllerTests.swift
//  GymondoTests
//
//  Created by Erfan Andesta on 27.01.24.
//

import XCTest
@testable import Gymondo

final class ExerciseDetailTableViewControllerTests: XCTestCase {
    
    var sut: ExerciseDetailTableViewController!
    var mockViewModel = MockExerciseDetailViewModel()
    var coordinator = MockExerciseDetailCoordinator()
    
    override func setUp() {
        super.setUp()
        //Given
        sut = ExerciseDetailTableViewController(viewModel: mockViewModel, coordinator: coordinator)
    }
    
    func test_initial_data() {
        //Then
        XCTAssertEqual(sut.view.subviews.count, 1)
        XCTAssertNotNil(sut.view.subviews[0] as? UITableView)
        XCTAssertTrue(sut.tableView.dataSource === sut.viewModel.dataSource)
        XCTAssertTrue(sut.tableView.delegate === sut)
    }
    func test_cells_height() {
        //When
        let titleHeight = sut.tableView(sut.tableView, heightForRowAt: IndexPath(row: 0, section: 0))
        let variationsHeight = sut.tableView(sut.tableView, heightForRowAt: IndexPath(row: 0, section: 1))
        let imagesHeight = sut.tableView(sut.tableView, heightForRowAt: IndexPath(row: 0, section: 2))
        
        //Then
        XCTAssertEqual(titleHeight, UITableView.automaticDimension)
        XCTAssertEqual(variationsHeight, UITableView.automaticDimension)
        XCTAssertEqual(imagesHeight, 100)
    }
    func test_didSelect() {
        //When
        sut.tableView(sut.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        sut.tableView(sut.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        sut.tableView(sut.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        sut.tableView(sut.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        
        //Then
        XCTAssertEqual(coordinator.count, 4)
    }
    
}
