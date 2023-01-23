//
//  WeatherSection1View.swift
//  WeatherDemo
//
//  Created by Hardik Darji on 24/01/23.
//

import SwiftUI

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
