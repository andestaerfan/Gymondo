//
//  ExerciseDetailFactory.swift
//  Gymondo
//
//  Created by Erfan Andesta on 27.01.24.
//

import Foundation

protocol ExerciseDetailViewModelProtocol: ExerciseDetailViewProtocol, ExerciseDetailViewModel {}

struct ExerciseDetailFactory {
    
    func makeExerciseDetailViewModel(with id: Int) -> ExerciseDetailViewModelProtocol {
        let networkRequest = NetworkRequest(base: AppConstants.APIConstants.baseAPI)
        let usecase = MainExerciseDetailUseCase(request: networkRequest)
        let imageLoader = ImageLoaderClient(dataRequest: HTTPDataRequestClient())
        let dataSource = ExerciseDetailDataSource(imagesDataSource: ExerciseImagesDataSource())
        return MainExerciseDetailViewModel(usecase: usecase,
                                       imageLoader: imageLoader,
                                       dataSource: dataSource,
                                       id: id)
    }
}
