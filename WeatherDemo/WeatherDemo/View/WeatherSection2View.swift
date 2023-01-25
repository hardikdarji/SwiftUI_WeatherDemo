//
//  WeatherSection2View.swift
//  WeatherDemo
//
//  Created by Hardik Darji on 24/01/23.
//

import SwiftUI
struct Section2View: View{
    @Binding var arrModel: [Forecastday]
    var body: some View {
        ScrollView(.horizontal){
            HStack{
                if let arrData = arrModel{
                    ForEach(arrData) { model in
                        Spacer()
                        DayInfoView(objModelData: model)
                        Spacer()
                    }
                }
            }
            
        }
    }
}


