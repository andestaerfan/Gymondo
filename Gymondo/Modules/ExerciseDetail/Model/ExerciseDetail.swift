//
//  ExerciseDetail.swift
//  Gymondo
//
//  Created by Erfan Andesta on 27.01.24.
//

import Foundation

struct ExerciseDetail: Decodable {
    let images: [ExerciseImage]
    let variations: [Int]
    let name: String
    
    struct ExerciseImage: Decodable {
        let image: String
    }
}
