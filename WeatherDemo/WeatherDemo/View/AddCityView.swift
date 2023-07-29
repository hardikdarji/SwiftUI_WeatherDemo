//
//  AddCityView.swift
//  WeatherDemo
//
//  Created by Hardik Darji on 27/02/23.
//

import SwiftUI

struct AddCityView: View {
    @Binding var cities: [City]
    @Binding var isShowingSheet: Bool
    @State var objCity = City()
    @State var isShowError: Bool = false

    var body: some View {
        NavigationView{
            VStack{
                Text("Add New City")
                    .font(.largeTitle)
                    
                HStack{
                    Spacer(minLength: 12)
                    VStack{
                        TextField("City Name", text: $objCity.name)
                            .textFieldStyle(.roundedBorder)
                            .onSubmit {
                                isShowError = false
                            }
                            .onChange(of: objCity.name) { newValue in
                                if newValue.count > 0
                                {
                                    isShowError = false
                                }
                            }
                            
                    }
                    Button {
                        validateCity()
                        if !isShowError {
                            cities.append(City(name: objCity.name))
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
            if objCity.name.trimmingCharacters(in: .whitespaces).count == 0
            {
                isShowError = true
            }
            else
            {
                isShowError = false
            }
        }
    
}
//
//struct AddCityView_Previews: PreviewProvider {
//    @State static var cities = [City(name: "Ahmedabad")]
//    @State static private var isShowingSheet = true
//
//    static var previews: some View {
//        AddCityView(cities: $cities, isShowingSheet: $isShowingSheet)
//    }
//}
