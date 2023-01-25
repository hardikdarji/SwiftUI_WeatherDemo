//
//  DayInfoView.swift
//  WeatherDemo
//
//  Created by Hardik Darji on 25/01/23.
//

import SwiftUI
struct DayInfoView: View{
    var objModelData:Forecastday?
//    @Binding var isDetailView: Bool
    var body: some View {
        VStack{
            if let objModel = objModelData
            {
                if let val = objModel.date
                {
                    Text(val)
                        .font(.system(size: 16, weight: .regular, design: .rounded))
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
        }
        .gesture(
            TapGesture()
                .onEnded({ val in
//                    self.isDetailView = !self.isDetailView
                    print("touched: \(val)")
                })
        )
    }
}
