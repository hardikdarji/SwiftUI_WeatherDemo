//
//  WeatherView.swift
//  WeatherDemo
//
//  Created by Hardik Darji on 23/01/23.
//

import SwiftUI
struct WeatherSwiftUIView: View {
    @ObservedObject var objWeatherVM = WeatherViewModel()
    @State var isProgressViewShow: Bool = true
    @State var cities:[String]?

    var body: some View {
        ScrollView{
            VStack{
                if self.isProgressViewShow{
                    ProgressView {
                        Text("Loading...")
                    }
                }
                //section1View(objWeatherModel: $objWeatherVM.objWeatherData, arrCities: $cities)
                section1View(objWeatherModel: $objWeatherVM.objWeatherData,
                             arrCities: $cities)
                    .padding(32)
                section2View(objWeatherModel: $objWeatherVM.objWeatherData)
                
                Spacer()
            }
            .onAppear {
                Task{
                    cities = ["Ahmedabad", "Surat"]
                    let apiKey = "522db6a157a748e2996212343221502"
                    if let city = cities?.first
                    {
                        await self.objWeatherVM.getWeatherData(manager: APIManager(), apiKey: apiKey, city: city)
                        self.isProgressViewShow = false
                    }
                    
                }
            }
        }
    }
}
struct section2View: View{
    @Binding var objWeatherModel:WeatherModel?

    var body: some View {
        ScrollView{
            HStack{
                if let arrData = objWeatherModel?.forecast?.forecastday{
                    ForEach(arrData) { objModel in
                        Spacer()
                        VStack{
                            if let val = objModel.date
                            {
                                Text(val)
                                    .font(.system(size: 16, weight: .regular, design: .rounded))
    //                                .padding()
                            }
                            if let icon = objModel.day?.condition?.icon,
                               let url = URL(string: "https:\(icon)")
                            {
                                if #available(iOS 15.0, *) {
                                    AsyncImage(url: url) { image in
                                        image.resizable()
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    .frame(width: 50, height: 50)
                                } else {
                                    // Fallback on earlier versions
                                    NetworkImage(url: url)
                                        .frame(width: 50, height: 50)
                                }
                            }
                            if let highT = objModel.day?.maxtemp_c
                            {
                                Text("H:\(String(Int(highT)))°")
                                    .font(.system(size: 14, weight: .regular))
                                    .foregroundColor(.gray)
                            }
                            if let lowT = objModel.day?.mintemp_c
                            {
                                Text("L:\(String(Int(lowT)))°")
                                    .font(.system(size: 14, weight: .regular))
                                    .foregroundColor(.gray)
                            }
                        }
                        Spacer()
                    }
                }
            }
        }
        
    }
}
struct section1View: View{
    @Binding var objWeatherModel:WeatherModel?
    @Binding var arrCities:[String]?
    @State var selectedIndex = 0

    var body: some View {
        VStack{
            if let val = objWeatherModel?.location?.name
            {
                Text(val)
                    .font(.system(size: 36, weight: .bold, design: .rounded))
            }

            if let region = objWeatherModel?.location?.region,
               let country = objWeatherModel?.location?.country
            {
                Text("\(region), \(country)")
                    .font(.system(size: 15, weight: .thin))
            }
            if let dateTime = objWeatherModel?.location?.localtime
            {
                Text(dateTime)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.gray)
                    .padding()
            }
        
           
            if let val = objWeatherModel?.current?.temp_c
            {
                Text("\(String(Int(val)))°")
                    .font(.system(size: 50, weight: .thin, design: .rounded))
            }
            HStack{
                if let val = objWeatherModel?.current?.condition?.text
                {
                    Text(val)
                        .font(.system(size: 26, weight: .medium, design: .rounded))
                        .foregroundColor(.blue)
                    
                }
                if let icon = objWeatherModel?.current?.condition?.icon,
                   let url = URL(string: "https:\(icon)")
                {
                    NetworkImage(url: url)
                        .frame(width: 40, height: 40)
                }
            }
            
            if let highT = objWeatherModel?.forecast?.forecastday?.first?.day?.maxtemp_c,
               let lowT = objWeatherModel?.forecast?.forecastday?.first?.day?.mintemp_c
            {
                Text("H:\(String(Int(highT)))° L:\(String(Int(lowT)))°")
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(.gray)
            }
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
    var body: some Scene {
        WindowGroup {
            WeatherSwiftUIView()
        }
    }
}
