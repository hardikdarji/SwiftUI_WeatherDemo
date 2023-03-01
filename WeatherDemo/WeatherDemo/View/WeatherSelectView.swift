//
//  WeatherSelectVC.swift
//  WeatherDemo
//
//  Created by Hardik Darji on 26/02/23.
//

import SwiftUI

struct WeatherSelectViewUI: View {
    @State var cities = [String]()
    @State private var isShowingSheet = false

    var body: some View {
        NavigationView {
            List() {
                ForEach(cities, id: \.self) { model in
                    Text("\(model)")
                }
            }
            .navigationBarItems(trailing:
                                    Button(action: {
                isShowingSheet.toggle()
            }, label: {
              Text("Add")
            })
            .sheet(isPresented: $isShowingSheet, content: {
                AddCityView(cities: $cities, isShowingSheet: $isShowingSheet)
            })
//                                    NavigationLink {
//                AddCityView(cities: $cities)
//                                    } label: {
//                                        Text("Add City")
//                                    }
            )
            .navigationTitle("Select City")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
struct WeatherSelectViewUI_Previews: PreviewProvider {
    static var previews: some View {
        WeatherSelectViewUI()
    }
}

@main
struct WeatherSelectView: App {
    @StateObject private var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            WeatherSelectViewUI()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
