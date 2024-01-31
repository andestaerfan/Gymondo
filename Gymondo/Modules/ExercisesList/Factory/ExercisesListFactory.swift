//
//  ExercisesListFactory.swift
//  Gymondo
//
//  Created by Erfan Andesta on 26.01.24.
//

import Foundation

struct ExercisesListFactory {
    
    func makeExercisesListStore() -> MainExercisesListStore {
        let useCase = makeExercisesListUseCase()
        let httpDataRequest = HTTPDataRequestClient()
        let imageLoader = ImageLoaderClient(dataRequest: httpDataRequest)
        let exercisesImageHandler = MainExercisesImageManager(usecase: useCase,
                                                              imageLoader: imageLoader)
        return MainExercisesListStore(usecase: useCase,
                                      imageHandler: exercisesImageHandler)
    }
    private func makeExercisesListUseCase() -> MainExercisesListUseCase {
        let decoder = CustomJSONDecoderDecorator()
        let httpDataRequest = HTTPDataRequestClient()
        let requesteClient = NetworkRequesterClient()
        let apiRequest = APIRequestClient(decoder: decoder,
                                          dataRequest: httpDataRequest,
                                          networkRequester: requesteClient)
        let request = NetworkRequest(base: AppConstants.APIConstants.baseAPI)
        return MainExercisesListUseCase(apiRequester: apiRequest,
                                    request: request)
    }
}
