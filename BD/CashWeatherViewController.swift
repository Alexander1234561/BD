import UIKit
import RealmSwift

class AlamViewController: UIViewController {
    //var weatherForecast: Array <WeatherMoscow> = []

    @IBOutlet weak var currentDateLabel: UILabel!
    @IBOutlet weak var currentWeatherLabel: UILabel!
    @IBOutlet weak var currentTemperature: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    
    @IBOutlet weak var tableView: UITableView!
    
    private let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if realm.objects(WeatherM.self).count != 0  {
            self.currentWeatherLabel.text = "\(self.realm.objects(WeatherM.self).first!.des)"
            self.currentDateLabel.text = "\(self.realm.objects(WeatherM.self).first!.time)"
            self.weatherImage.image = self.imageChoice(data: self.realm.objects(WeatherM.self).first!)
            self.currentTemperature.text = self.realm.objects(WeatherM.self).first!.temp
        }
        LoadedData.loadWeatherInMoscow(completion: {weather in
            for i in self.realm.objects(WeatherM.self){
                try! self.realm.write{ self.realm.delete(i) }
            }
            for i in weather {
                let wm = WeatherM()
                wm.des = i.description
                wm.temp = "\(Int(i.temp))°"
                wm.time = i.time
                try! self.realm.write{self.realm.add(wm)}
            }
            self.currentWeatherLabel.text = "\(self.realm.objects(WeatherM.self).first!.des)"
            self.currentDateLabel.text = "\(self.realm.objects(WeatherM.self).first!.time)"
            self.weatherImage.image = self.imageChoice(data: self.realm.objects(WeatherM.self).first!)
            self.currentTemperature.text = self.realm.objects(WeatherM.self).first!.temp
            
            
            self.tableView.reloadData()
        })
    }
    
    func imageChoice(data: WeatherM) -> UIImage {
        if (data.des.contains("rain") || data.des.contains("Rain")){
            return UIImage(named: "rain")!
        }
        
        if (data.des.contains("snow") || data.des.contains("Snow")){
            return UIImage(named: "snow")!
        }
        
        if (data.des.contains("thunderstorm") || data.des.contains("Thunderstorm")){
            return UIImage(named: "storm")!
        }
        
        if (data.des.contains("clear") || data.des.contains("Clear")){
            return UIImage(named: "sun")!
        }
        
        return UIImage(named: "cloud")!
    }
}

extension AlamViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return realm.objects(WeatherM.self).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dvc = tableView.dequeueReusableCell(withIdentifier: "AlamWeatherCell") as! WeatherTableViewCell
        
        dvc.dayLabel.text = "\(realm.objects(WeatherM.self)[indexPath.row].time)"
        dvc.temperatureLabel.text = self.realm.objects(WeatherM.self)[indexPath.row].temp
        dvc.weatherLabel.text = "\(realm.objects(WeatherM.self)[indexPath.row].des)"
        dvc.weatherImage.image = self.imageChoice(data: realm.objects(WeatherM.self)[indexPath.row])
        return dvc
    }
}
