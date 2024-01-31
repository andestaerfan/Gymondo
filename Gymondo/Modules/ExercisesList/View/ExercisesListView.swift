//
//  ExercisesListView.swift
//  Gymondo
//
//  Created by Erfan Andesta on 26.01.24.
//

import SwiftUI

protocol ExercisesListViewCoordinator: AnyObject {
    func didTapOn(index: Int)
}
struct ExercisesListView: View {
    
    @ObservedObject var store: MainExercisesListStore
    weak var coordinator: ExercisesListViewCoordinator?
    
    init(store: MainExercisesListStore, coordinator: ExercisesListViewCoordinator?) {
        self.store = store
        self.coordinator = coordinator
    }
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 10) {
                ForEach(store.exercises.indices, id: \.self) { index in
                    Button {
                        coordinator?.didTapOn(index: index)
                    } label: {
                        ExerciseItemView(viewModel: store.exercises[index]) {
                            Image("img")
                                .resizable()
                        }
                        .padding(5)
                        .overlay(content: {
                            RoundedRectangle(cornerRadius: 5)
                                .stroke()
                        })
                        .padding(.horizontal)
                        .contentShape(Rectangle())
                        .onAppear {
                            store.didAppear(index)
                        }
                        .onDisappear {
                            store.didDisappear(index)
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
        .onAppear {
            store.load()
        }
        .navigationBarTitle("Exercises", displayMode: .inline)
    }
}

#Preview {
    let exercises = [
        ExerciseViewModel(id: 1, name: "Exercise 1"),
        ExerciseViewModel(id: 174, name: "Exercise 2"),
        ExerciseViewModel(id: 3, name: "Exercise 3")
    ]
    let store = ExercisesListFactory().makeExercisesListStore()
    store.exercises = exercises
    return ExercisesListView(store: store, coordinator: nil)
}
