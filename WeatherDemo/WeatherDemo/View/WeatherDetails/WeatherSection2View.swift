//
//  WeatherSection2View.swift
//  WeatherDemo
//
//  Created by Hardik Darji on 24/01/23.
//

import SwiftUI
struct Section2Container: View{
    @Binding var arrModel: [Forecastday]
    @State var selectedDate: String
    var body: some View {
        if self.selectedDate.count > 0
        {
            if let index = arrModel.firstIndex(where: { forcastDay in
                forcastDay.date == self.selectedDate
            }) {

                //SHOW DETAIL, HOURS VIEW FOR SELECTED DATE
                HoursView(arrModel: $arrModel[index].hour ?? [], selectedDate: $selectedDate)
            }
        }
        else
        {
            //  SHOW DATE VIEW
            DaysView(arrModel: $arrModel, selectedDate: $selectedDate)
        }
    }
}

struct HoursView: View{
    @Binding var arrModel: [Hour]
    @Binding var selectedDate: String
    
    var body: some View {
        VStack{
            HStack{
                
                Text(selectedDate)
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                Spacer()
                Text("Back")
                    .foregroundColor(.gray)
                    .font(.system(size: 22, weight: .ultraLight, design: .rounded))
                    .gesture(
                        TapGesture()
                            .onEnded({ _ in
                                selectedDate = ""
                            })
                    )
            }
            .padding(12)
//            .background(Color(red: 242 / 255, green: 242 / 255, blue: 242 / 255))
            .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.secondary, lineWidth: 0.2)
                    )
            
            ScrollView(.horizontal){
                HStack{
                    if let arrData = arrModel{
                        ForEach(arrData) { model in
                            Spacer()
                            HourInfoView(objModelData: model)
                            Spacer()
                        }
                    }
                }
            }
        }
        
    }
}


struct DaysView: View{
    @Binding var arrModel: [Forecastday]
    @Binding var selectedDate: String
    var body: some View {
        ScrollView(.horizontal){
            HStack{
                if let arrData = arrModel{
                    ForEach(arrData) { model in
                        Spacer()
                        //  SHOW for DATES
                        DayInfoView(objModelData: model,
                                    selectedDate: $selectedDate)
                        Spacer()
                    }
                }
            }
            
        }
    }
}



