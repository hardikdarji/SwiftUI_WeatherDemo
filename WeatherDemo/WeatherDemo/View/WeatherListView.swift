//
//  WeatherSelectVC.swift
//  WeatherDemo
//
//  Created by Hardik Darji on 26/02/23.
//

import SwiftUI
struct CityCell: View {
    @Binding var objCity: City
    @State var isSelected: Bool = false
    var body: some View {
        Text(objCity.name)
            .foregroundColor(.gray)
            .frame(maxWidth: .infinity,
                   minHeight: 44,
                   maxHeight: isSelected ? .infinity - 44 : 44)
    }
}

struct WeatherListViewUI: View {
    @State var cities = [City]()
    @State private var isShowingSheet = false
    
    var body: some View {
        NavigationView {
            List($cities) { model in
                NavigationLink {
                    WeatherInfoView(objCity: model)
                } label: {
                    CityCell(objCity: model)
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
            )
            .navigationTitle("Select City")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
struct WeatherListViewUI_Previews: PreviewProvider {
    static var previews: some View {
        WeatherListViewUI()
    }
}

@main
struct WeatherListView: App {
    @StateObject private var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            WeatherListViewUI()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
