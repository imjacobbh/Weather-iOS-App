//
//  WeatherMananger.swift
//  Clima
//
//  Created by Jacob Bonilla on 8/19/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation
struct WeatherMananger {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=176abef1bc1df042dc55944f3b231b53&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        print(urlString)
        
        performRequest(urlString)
    }
    
    func fetchWeather(long: Double, lat: Double){
        let urlString = "\(weatherURL)&lon=\(long)&lat=\(lat)"
        print(urlString)
        
        performRequest(urlString)
    }
    
    func performRequest(_ urlString: String){
        // 1. Create a URL
        if let url = URL(string: urlString) {
            // 2. Create a URLSession
            let session = URLSession(configuration: .default)
            // 3. Give the session a task
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)
                    delegate?.didFailWithError(error!)
                    return
                }
                if let safeData = data {
                    if let weather = parseJSON(safeData) {
                        delegate?.didUpdateWeather(weather)
                    }
                }
            }
            // 4. Start the task
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let weatherModel = WeatherModel(cityName: decodedData.name, conditionID: decodedData.weather[0].id, temperature: decodedData.main.temp)
            return weatherModel
        }catch {
            delegate?.didFailWithError(error)
            print(error)
        }
        return nil
    }
    
}
