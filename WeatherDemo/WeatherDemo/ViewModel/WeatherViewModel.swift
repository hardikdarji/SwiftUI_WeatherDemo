//
//  WeatherViewModel.swift
//  test_Exercise
//
//  Created by Hardik Darji on 21/01/23.
//

import Foundation
import Combine
class WeatherViewModel: ObservableObject{
    @Published var objWeatherData: WeatherModel?
    func getWeatherData(manager: APIManager, apiKey: String, city: String) async
    {
        let url = String(format: APIs.WeatherData.rawValue, apiKey, city)
        let result = await manager.fetch(strUrl: url,
                                objectType: WeatherModel.self)
        switch result {
        case .failure(let error):
            print(error)
        case .success(let object):
            DispatchQueue.main.async {
                self.objWeatherData = object
            }
        }
    }
}
