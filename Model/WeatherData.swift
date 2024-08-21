//
//  WeatherData.swift
//  Clima
//
//  Created by Jacob Bonilla on 8/20/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Decodable {
    let temp: Double
}

struct Weather : Decodable {
    let id: Int
}
