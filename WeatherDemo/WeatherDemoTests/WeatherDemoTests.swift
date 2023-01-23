//
//  WeatherDemoTests.swift
//  WeatherDemoTests
//
//  Created by Hardik Darji on 23/01/23.
//

import XCTest
@testable import WeatherDemo

class WeatherDemoTests: XCTestCase {

    var sut: WeatherViewModel!

    override func setUp()  {
        super.setUp()
        sut = WeatherViewModel()
    }
    override func tearDown()  {
        super.tearDown()
        sut = nil
    }
    
    func testGetWeatherData() async {
        let apiKey = "522db6a157a748e2996212343221502"
        let city = "Ahmedabad"
        //let city = "Rajkot"
        let expectation = expectation(description: "Test WeatherApp")

        await sut.getWeatherData(manager: APIManager(), apiKey: apiKey, city: city)
        //
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.5)
        XCTAssertGreaterThan(sut.objWeatherData?.forecast?.forecastday?.count ?? 0 , 0)
    }

}
