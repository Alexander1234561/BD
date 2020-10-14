import Foundation
import RealmSwift

class WeatherM: Object {
    @objc dynamic var time = ""
    @objc dynamic var des = ""
    @objc dynamic var temp: String = ""
}

class WeatherMoscow {
    let time: String
    let description: String
    let temp: Double
    
    init(time: Double, description: String, temp: Double) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let date = Date(timeIntervalSince1970: time)
        
        self.temp = temp
        self.time = formatter.string(from: date as Date)
        self.description = description
    }
}
