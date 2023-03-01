//
//  WeatherView+Ext.swift
//  WeatherDemo
//
//  Created by Hardik Darji on 24/01/23.
//

import CoreData
//TO MANAGE HELPER METHODS
extension WeatherSwiftUIView
{
    //ADD DATA, FETCHED FORM API CALL
    func addData()
    {
        do{
            let dataModel = Weather(context: viewContext)
            if let data = try objWeatherVM.objWeatherData?.toJSON() as? String
            {
                dataModel.data = data
            }
            saveContext()
        }
        catch{
            print(error)
        }
        
    }
    func setupData(isRefresh: Bool = false)
    {
        Task{
            //CHECK IN STORED DATA, IF EXIST THEN SHOW FROM STORED DATA..
            if let JSON = weatherData.first?.data, !isRefresh
            {
                let jsonData = JSON.data(using: .utf8)!
                let objWeatherModel: WeatherModel = try! JSONDecoder().decode(WeatherModel.self, from: jsonData)
                self.objWeatherVM.objWeatherData = objWeatherModel
            }
            else
            {
                //API CALL
                cities = ["Ooty", "Surat"]
                let apiKey = "522db6a157a748e2996212343221502"
                if let city = cities?.first
                {
                    await self.objWeatherVM.getWeatherData(manager: APIManager(), apiKey: apiKey, city: city)
                    self.addData()
                }
            }
            self.isProgressViewShow = false
            
            arrDays = self.objWeatherVM.objWeatherData?.forecast?.forecastday
        }
    }
    //SAVE DATA TO Weather
    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            let error = error as NSError
            fatalError("An error occured: \(error)")
        }
    }
}
