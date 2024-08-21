//
//  WeatherManagerDelegate.swift
//  Clima
//
//  Created by Jacob Bonilla on 8/20/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation


protocol WeatherManagerDelegate {
    
    func didUpdateWeather(_ weather: WeatherModel)
    func didFailWithError(_ error: Error)
}
