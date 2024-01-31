//
//  MockExerciseDetailViewModel.swift
//  GymondoTests
//
//  Created by Erfan Andesta on 28.01.24.
//

import Foundation
import Combine
@testable import Gymondo

final class MockExerciseDetailViewModel: ExerciseDetailViewModelProtocol {
    
    var detail: ExerciseDetail = .init(images: [], variations: [], name: "")
    
    func load() -> AnyPublisher<Void, Error> {
        Result.Publisher(.success(()))
            .eraseToAnyPublisher()
    }
    
    var navigateToDetail: PassthroughSubject<Int, Never> = .init()
    
    var dataSource: ExerciseDetailDataSourceProtocol = ExerciseDetailDataSource(imagesDataSource: ExerciseImagesDataSource())
    
    
}
