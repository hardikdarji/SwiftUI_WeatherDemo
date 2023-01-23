//
//  WeatherSection2View.swift
//  WeatherDemo
//
//  Created by Hardik Darji on 24/01/23.
//

import SwiftUI
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

