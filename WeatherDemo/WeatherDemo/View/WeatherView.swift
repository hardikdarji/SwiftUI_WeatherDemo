//
//  WeatherView.swift
//  WeatherDemo
//
//  Created by Hardik Darji on 23/01/23.
//

import SwiftUI
import CoreData

struct WeatherSwiftUIView: View {
    //VIEWMODEL OBJECT
    @ObservedObject var objWeatherVM = WeatherViewModel()
    
    //TO MANAGE LOADER
    @State var isProgressViewShow: Bool = true
    
    //LIST OF CITIES TO BE SELECTED AND GET DATA
    @State var cities:[String]?
    
    //TO FETCH DATA FROM CORE DATA STORAGE...
    @FetchRequest(entity: Weather.entity(), sortDescriptors: [])
    var weatherData:FetchedResults<Weather>
    @Environment(\.managedObjectContext) var viewContext
    
    @State var arrDays: [Forecastday]?
    
    var body: some View {
        NavigationView{
            List{
                VStack{
                    if self.isProgressViewShow{
                        ProgressView {
                            Text("Loading...")
                        }
                    }
                    Section1View(objWeatherModel: $objWeatherVM.objWeatherData,
                                 arrCities: $cities)
                    .padding(32)
                    Section2Container(arrModel: $arrDays ?? [], selectedDate: "")
                    Spacer()
                }
            }
        }
        .refreshable {
            setupData(isRefresh: true)
        }
        .onAppear {
            setupData()
        }
    }
    
}

struct WeatherSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherSwiftUIView()
    }
}

@main
struct WeatherView: App {
    @StateObject private var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            WeatherSwiftUIView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
