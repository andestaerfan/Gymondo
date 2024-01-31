//
//  ExerciseDetailViewModel.swift
//  Gymondo
//
//  Created by Erfan Andesta on 27.01.24.
//

import Foundation
import Combine
import UIKit

enum Section: String, CaseIterable {
    case name
    case variations
    case images
}

protocol ExerciseDetailUseCase {
    func getExerciseDetail(for id: Int) -> AnyPublisher<ExerciseDetail, Error>
}
final class MainExerciseDetailViewModel: ExerciseDetailViewModelProtocol {
    
    private let usecase: ExerciseDetailUseCase
    private let id: Int
    private var imageLoader: ImageLoader
    private(set) var dataSource: ExerciseDetailDataSourceProtocol
    private(set) var detail = ExerciseDetail(images: [], variations: [], name: "")
    
    init(usecase: ExerciseDetailUseCase,
         imageLoader: ImageLoader,
         dataSource: ExerciseDetailDataSourceProtocol,
         id: Int) {
        self.usecase = usecase
        self.imageLoader = imageLoader
        self.dataSource = dataSource
        self.id = id
    }
    func load() -> AnyPublisher<Void, Error> {
        return usecase
            .getExerciseDetail(for: id)
            .map { [weak self] detail in
                self?.setDetail(detail)
                return ()
            }.eraseToAnyPublisher()
    }
    private func setDetail(_ detail: ExerciseDetail) {
        self.detail = detail
        let images = detail.images
            .compactMap {
                return imageLoader.getImage(for: $0.image)
            }
        dataSource.setData(title: detail.name,
                           variations: detail.variations,
                           images: images)
    }
}
