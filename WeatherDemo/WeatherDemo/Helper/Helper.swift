//
//  Helper.swift
//
//  Created by Hardik Darji on 22/01/23.
//

import UIKit
import Combine
import SwiftUI
enum RequestType: String{
    case GET, POST
}
// APIError enum which shows all possible Network errors
enum AppError: Error {
    case networkError(Error)
    case dataNotFound
    case jsonParsingError(Error)
    case invalidStatusCode(Int)
    case badURL(String)
    case badResponse(Error)
}
// Result enum to show success or failure
enum Result<T> {
    case success(T)
    case failure(AppError)
}
enum APIs: String{
    case WeatherData =
            "https://api.weatherapi.com/v1/forecast.json?key=%@&q=%@&days=7&aqi=no&alerts=no"
            
}
extension String{
    func toDate(format:String) -> Date? {
        
        let dateFormatter:DateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        if let dtDate = dateFormatter.date(from: self){
            return dtDate as Date?
        }
        return nil
    }
}
extension Date {
    func toString(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}

// SwiftUI Optional Binding
//usage $arrDays ?? []
func ??<T>(lhs: Binding<Optional<T>>, rhs: T) -> Binding<T> {
    Binding(
        get: { lhs.wrappedValue ?? rhs },
        set: { lhs.wrappedValue = $0 }
    )
}

// TO LOAD IMAGE FROM URL
struct NetworkImage: View {
    @StateObject private var viewModel = ViewModel()

    let url: URL?

    var body: some View {
        Group {
            if let data = viewModel.imageData, let uiImage = UIImage(data: data) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else if viewModel.isLoading {
                ProgressView()
            } else {
                Image(systemName: "photo")
            }
        }
        .onAppear {
            viewModel.loadImage(from: url)
        }
    }
}
extension NetworkImage {
    class ViewModel: ObservableObject {
        @Published var imageData: Data?
        @Published var isLoading = false

        private static let cache = NSCache<NSURL, NSData>()

        private var cancellables = Set<AnyCancellable>()

        func loadImage(from url: URL?) {
            isLoading = true
            guard let url = url else {
                isLoading = false
                return
            }
            if let data = Self.cache.object(forKey: url as NSURL) {
                imageData = data as Data
                isLoading = false
                return
            }
            URLSession.shared.dataTaskPublisher(for: url)
                .map { $0.data }
                .replaceError(with: nil)
                .receive(on: DispatchQueue.main)
                .sink { [weak self] in
                    if let data = $0 {
                        Self.cache.setObject(data as NSData, forKey: url as NSURL)
                        self?.imageData = data
                    }
                    self?.isLoading = false
                }
                .store(in: &cancellables)
        }
    }
}

extension Encodable {
    // Converting object to postable JSON
    func toJSON(_ encoder: JSONEncoder = JSONEncoder()) throws -> NSString {
        let data = try encoder.encode(self)
        let result = String(decoding: data, as: UTF8.self)
        return NSString(string: result)
    }
}
