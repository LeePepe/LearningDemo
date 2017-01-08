//
//  PickerViewController.swift
//  LearningFromBook
//
//  Created by 李天培 on 2017/1/4.
//  Copyright © 2017年 lee. All rights reserved.
//

import UIKit

struct Province {
    var name: String
    var cities = [City]()
    init(name: String, cities: [City]) {
        self.name = name
        self.cities = cities
    }
    init?(info: NSDictionary) {
        if let dict = info as? [String : Any] {
            if let name = dict["State"] as? String {
                self.name = name
                if let cities = dict["Cities"] as? [Dictionary<String, Any>] {
                    for city in cities {
                        if let cityName = city["city"] as? String,
                            let cityLat = city["lat"] as? Double,
                            let cityLon = city["lon"] as? Double {
                            self.cities.append(City(name: cityName, lat: cityLat, lon: cityLon))
                        }
                    }
                    return
                }
            }
        }
        return nil
    }
}

struct City {
    var name: String
    var lat: Double
    var lon: Double
}

class PickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var provincesAndCities = [Province]()

    @IBOutlet private weak var pickerView: UIPickerView! {
        didSet {
            pickerView.delegate = self
            pickerView.dataSource = self
        }
    }

    @IBOutlet private weak var infoLabel: UILabel!
    
    
    // MARK: - UIPickerViewDelegate
    
    private struct PickerViewRow {
        static let Provinces = 0
        static let Cities = 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case PickerViewRow.Provinces: return provincesAndCities[row].name
        case PickerViewRow.Cities: return provincesAndCities[pickerView.selectedRow(inComponent: 0)].cities[row].name
        default: return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (component == PickerViewRow.Provinces) {
            pickerView.reloadComponent(PickerViewRow.Cities)
        }
        let province = provincesAndCities[pickerView.selectedRow(inComponent: PickerViewRow.Provinces)].name
        let city = provincesAndCities[pickerView.selectedRow(inComponent: PickerViewRow.Provinces)].cities[pickerView.selectedRow(inComponent: PickerViewRow.Cities)].name
        infoLabel.text = "\(province) \(city)"
    }

    
    // MARK: - UIPickerViewDataSource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case PickerViewRow.Provinces: return provincesAndCities.count
        case PickerViewRow.Cities: return provincesAndCities[pickerView.selectedRow(inComponent: 0)].cities.count
        default: return 0
        }
    }
    
    // MARK: - View Controller LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        print(UserDefaults.standard.value(forKey: UserInfoKey.LoginUser))
        UserDefaults.standard.set(nil, forKey: UserInfoKey.LoginUser)
        loadData()
    }
    
    private func loadData() {
        if let path = Bundle.main.path(forResource: "ProvincesAndCities", ofType: "plist") {
            if let provinces = NSArray(contentsOfFile: path) as? Array<NSDictionary> {
                for provinceInfo in provinces {
                    if let newProvince = Province(info: provinceInfo) {
                        provincesAndCities.append(newProvince)
                    }
                }
            }
        }
    }
}

