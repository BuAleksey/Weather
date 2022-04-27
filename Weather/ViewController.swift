//
//  ViewController.swift
//  Weather
//
//  Created by Buba on 12.04.2022.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    @IBOutlet var nameCity: UILabel!
    @IBOutlet var iconWeather: UIImageView!
    @IBOutlet var tempLabel: UILabel!
    @IBOutlet var feelsLikeLabel: UILabel!
    @IBOutlet var cityNameTF: UITextField!
    @IBOutlet var serchButton: UIButton!
    @IBOutlet var mapButton: UIButton!
    
    var urlString = ""
    var lon = 0.0
    var lat = 0.0
    var nameCityStr = ""
    var weatherEmoji = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 0.62, green: 0.75, blue: 0.53, alpha: 1.00)
        
        nameCity.isHidden = true
        nameCity.textColor = UIColor(red: 0.38, green: 0.25, blue: 0.14, alpha: 1.00)
        
        tempLabel.isHidden = true
        tempLabel.textColor = UIColor(red: 0.38, green: 0.25, blue: 0.14, alpha: 1.00)
        
        feelsLikeLabel.isHidden = true
        feelsLikeLabel.textColor = UIColor(red: 0.38, green: 0.25, blue: 0.14, alpha: 1.00)
        
        serchButton.tintColor = UIColor(red: 0.38, green: 0.25, blue: 0.14, alpha: 1.00)
        
        mapButton.isHidden = true
        mapButton.tintColor = UIColor(red: 0.80, green: 0.44, blue: 0.29, alpha: 1.00)
    }
    
    @IBAction func searchCity(_ sender: Any) {
        
        let city = cityNameTF.text
        urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city!)&appid=0ed7355fd5989909915c772fabe33f22&units=metric"
        request(urlString: urlString) { weather, error in
            if weather != nil {
                self.nameCity.isHidden = false
                self.nameCity.text = weather?.name
                self.tempLabel.isHidden = false
                self.tempLabel.text = String("Temp \(weather?.main.tempString ?? "") °C")
                self.feelsLikeLabel.isHidden = false
                self.feelsLikeLabel.text = String("Feels like \(weather?.main.feelsLikeString ?? "") °C")
                self.iconWeather.image = UIImage(named: (weather?.weather.first?.idString)!)
                self.mapButton.isHidden = false
                self.lat = weather!.coord.lat
                self.lon = weather!.coord.lon
                self.nameCityStr = weather!.name
                self.weatherEmoji = weather!.weather.first!.idEmoji
            } else {
                let alert = UIAlertController(title: "Enter city name", message: nil, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .cancel)
                alert.addAction(okAction)
                self.present(alert, animated: true)
            }
    }
            }
    
    func request (urlString: String, complition: @escaping (SerchWeather?, Error?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, responss, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Some error")
                    complition(nil, error)
                    return
                }
                guard let data = data else { return }
                do {
                    let weather = try JSONDecoder().decode(SerchWeather.self, from: data)
                    complition(weather, nil)
                } catch let JSONError {
                    print("Filed to decode JSON", JSONError)
                    complition(nil, JSONError)
                }
            }
        }
        .resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let mapController = segue.destination as? MapViewController else { return }
                mapController.lat = self.lat
                mapController.lon = self.lon
        mapController.nameCity = self.nameCityStr
        mapController.weatherEmoji = self.weatherEmoji
    }
}
