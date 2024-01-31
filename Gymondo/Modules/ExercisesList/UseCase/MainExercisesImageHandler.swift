//
//  MainExercisesImageHandler.swift
//  Gymondo
//
//  Created by Erfan Andesta on 31.01.24.
//

import Foundation
import Combine
import UIKit

protocol ExercisesImageUseCase {
    func getExerciseImage(with id: Int) -> AnyPublisher<String?, Error>
}
class MainExercisesImageManager: ExercisesImageHandler {
    
    private let usecase: ExercisesImageUseCase
    private let imageLoader: ImageLoader
    
    private var exercisesImage = [Int: String?]()
    
    init(usecase: ExercisesImageUseCase,
         imageLoader: ImageLoader) {
        self.usecase = usecase
        self.imageLoader = imageLoader
    }
    
    func getExerciseImage(for id: Int) -> AnyPublisher<UIImage?, Error> {
        getExerciseImageUrl(for: id)
            .flatMap { [imageLoader] url in
                imageLoader.getImage(for: url ?? "")
            }
            .share()
            .eraseToAnyPublisher()
    }
    
    private func getExerciseImageUrl(for id: Int) -> AnyPublisher<String?, Error> {
        if let exerciseImageObject = exercisesImage[id], let url = exerciseImageObject {
            return Result.Publisher(.success(url))
                .eraseToAnyPublisher()
        }
        return usecase
            .getExerciseImage(with: id)
            .map { [weak self] string in
                self?.exercisesImage[id] = string
                return string
            }
            .share()
            .eraseToAnyPublisher()
    }
    
}
