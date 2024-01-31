//
//  ExercisesListStore.swift
//  Gymondo
//
//  Created by Erfan Andesta on 26.01.24.
//

import Foundation
import Combine
import SwiftUI

protocol ExercisesListUseCase {
    func getExercises() -> AnyPublisher<Exercises, Error>
}
protocol ExercisesImageHandler {
    func getExerciseImage(for id: Int) -> AnyPublisher<UIImage?, Error>
}
class MainExercisesListStore: ObservableObject {
    
    private let usecase: ExercisesListUseCase
    private let imageHandler: ExercisesImageHandler
    
    private(set) var exercisesImage = [Int: AnyCancellable]()
    private var cancellable: AnyCancellable?
    
    @Published var exercises: [ExerciseViewModel] = []
    
    init(usecase: ExercisesListUseCase,
         imageHandler: ExercisesImageHandler,
         exercises: [ExerciseViewModel] = []) {
        self.usecase = usecase
        self.imageHandler = imageHandler
        
    }
    
    func load() {
        guard exercises.isEmpty else { return }
        cancellable?.cancel()
        cancellable = nil
        cancellable = usecase
            .getExercises()
            .receive(on: DispatchQueue.main)
            .sink { completion in
            } receiveValue: { [weak self] exercises in
                self?.exercises = exercises.results.map { ExerciseViewModel(id: $0.id, name: $0.name) }
            }
    }
    func didAppear(_ index: Int) {
        guard 0..<exercises.count ~= index,
              exercises[index].image == nil else { return }
        let exercise = exercises[index]
        
        let cancellable = imageHandler.getExerciseImage(for: exercise.id)
            .receive(on: DispatchQueue.main)
            .sink { comp in
                
            } receiveValue: { [weak self] image in
                self?.exercises[index].image = image
            }
        
        exercisesImage[exercise.id] = cancellable
    }
    func didDisappear(_ index: Int) {
        guard 0..<exercises.count ~= index,
              let exerciseImage = exercisesImage[exercises[index].id] else { return }
        exerciseImage.cancel()
        exercisesImage.removeValue(forKey: exercises[index].id)
    }
}
