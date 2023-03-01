//
//  AddCityView.swift
//  WeatherDemo
//
//  Created by Hardik Darji on 27/02/23.
//

import SwiftUI

struct AddCityView: View {
    @Binding var cities: [String]
    @Binding var isShowingSheet: Bool
    @State var cityName: String = ""
    @State var isShowError: Bool = false
    

    var body: some View {
        NavigationView{
            VStack{
                Text("Add New City")
                    .font(.largeTitle)
                    
                HStack{
                    Spacer(minLength: 12)
                    VStack{
                        TextField("City Name", text: $cityName)
                            .textFieldStyle(.roundedBorder)
                            .onSubmit {
                                isShowError = false
                            }
                            .onChange(of: cityName) { newValue in
                                if newValue.count > 0
                                {
                                    isShowError = false
                                }
                            }
                            
                    }
                    Button {
                        validateCity()
                        if !isShowError {
                            cities.append(cityName)
                            isShowingSheet = false
                        }
                    } label: {
                        Text("Submit")
                            .bold()
                    }
                    .buttonBorderShape(.roundedRectangle)
                    Spacer(minLength: 12)
                    
                }
                if isShowError{
                    HStack {
                        Text("")
                        Text("Please enter valid city name")
                                .font(.system(size: 12, weight: .light, design: .rounded))
                            .foregroundColor(.red)
                        Spacer()
                    }
                }
                Spacer()
                }
            }
    
    }
        func validateCity()
        {
            if cityName.trimmingCharacters(in: .whitespaces).count == 0
            {
                isShowError = true
            }
            else
            {
                isShowError = false
            }
        }
    
}
struct AddCityView_Previews: PreviewProvider {
    @State static var cities = ["Ahmedabad", "Surat"]
    @State static private var isShowingSheet = true

    static var previews: some View {
        AddCityView(cities: $cities, isShowingSheet: $isShowingSheet)
    }
}
