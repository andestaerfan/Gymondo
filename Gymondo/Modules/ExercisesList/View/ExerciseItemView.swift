//
//  ExerciseItemView.swift
//  Gymondo
//
//  Created by Erfan Andesta on 26.01.24.
//

import SwiftUI

protocol ExerciseItemViewModel {
    var name: String { get }
    var image: UIImage? { get }
}
struct ExerciseItemView<Placeholder: View>: View {
    
    private let viewModel: ExerciseItemViewModel
    private let placeholder: Placeholder
    
    init(viewModel: ExerciseItemViewModel, @ViewBuilder placeholder: () -> Placeholder) {
        self.viewModel = viewModel
        self.placeholder = placeholder()
    }
    
    var body: some View {
        HStack(alignment: .center) {
            Text(viewModel.name)
            Spacer()
            VStack {
                if let image = viewModel.image {
                    Image(uiImage: image)
                        .resizable()
                } else {
                    placeholder
                }
            }
            .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
        }
    }
}

#Preview("with image") {
    var viewModel = ExerciseViewModel(id: 1, name: "Exercise 1")
    viewModel.image = UIImage(named: "img")
    return ExerciseItemView(viewModel: viewModel) {
        Color.gray
    }
}
#Preview("with placeholder") {
    let viewModel = ExerciseViewModel(id: 1, name: "Exercise 1")
    return ExerciseItemView(viewModel: viewModel) {
        Color.gray
    }
}
