//
//  WeatherView.swift
//  WeatherDemo
//
//  Created by Hardik Darji on 23/01/23.
//

import SwiftUI

@main
struct WeatherView: App {
    var body: some Scene {
        WindowGroup {
            WeatherSwiftUIView()
        }
    }
}
struct WeatherSwiftUIView: View {
    var body: some View {
        Text("Hello!")
    }
}


struct WeatherSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherSwiftUIView()
    }
}
