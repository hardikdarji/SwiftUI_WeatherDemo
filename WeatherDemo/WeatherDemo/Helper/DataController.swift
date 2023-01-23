//
//  DataController.swift
//  WeatherDemo
//
//  Created by Hardik Darji on 23/01/23.
//

import CoreData
class DataController: ObservableObject{
    let container = NSPersistentContainer(name: "WeatherData")
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
