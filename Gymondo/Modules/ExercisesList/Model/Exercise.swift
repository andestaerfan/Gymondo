//
//  Exercise.swift
//  Gymondo
//
//  Created by Erfan Andesta on 26.01.24.
//

import Foundation
import UIKit
import Combine

struct Exercises: Decodable {
    let results: [Exercise]
}
struct Exercise: Decodable {
    let id: Int
    let name: String
}
struct ExerciseImage: Decodable {
    let id: Int
    let image: String?
}
struct ExerciseViewModel: ExerciseItemViewModel {
    
    let id: Int
    let name: String
    var image: UIImage?
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}
