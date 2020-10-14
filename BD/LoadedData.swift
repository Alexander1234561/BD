import Foundation
import Alamofire

class LoadedData{
    
    static func loadWeatherInMoscow(completion: @escaping([WeatherMoscow]) -> Void) {
        Alamofire.request("https://api.openweathermap.org/data/2.5/onecall?lat=55.7522&lon=37.6156&exclude=hourly,minutly,current,alerts&units=metric&appid=709c6ede6fe687c28778dfe8a5fb981f").responseData { response in
            let welcome = try? JSONDecoder().decode(Welcome.self, from: response.data!)
            var weatherForecast: Array<WeatherMoscow> = []
            for i in (welcome?.daily)! {
                let weatherMoscow = WeatherMoscow(time: Double(i.dt), description: i.weather[0].weatherDescription, temp: (i.temp.max + i.temp.min)/2)
                weatherForecast.append(weatherMoscow)
                DispatchQueue.main.async { completion(weatherForecast) }
            }
        }
    }
}
