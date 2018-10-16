//
//  HomeViewController.swift
//  SoleelkLab
//
//  Created by Ramzy on 10/15/18.
//  Copyright © 2018 Ramzy. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Firebase


class HomeViewController: UIViewController, UIPickerViewDelegate,UIPickerViewDataSource {
    
    
    @IBOutlet weak var countryListPickerView: UIPickerView!
    var countryData : [Country] = [Country]()
    override func viewDidLoad() {
       

        // Do any additional setup after loading the view.
        
        getCountries(completion: { (error: Error?, countries:[Country]?) in
            self.countryData = countries!
            self.countryListPickerView.reloadAllComponents()
            
        })
        
        
        
        self.countryListPickerView.delegate = self
        self.countryListPickerView.dataSource = self
        
         super.viewDidLoad()
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countryData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return countryData[row].countryName
    }

    
    func getCountries(completion: @escaping (_ error: Error?, _ countries: [Country]?) -> Void ){
        let url = "https://restcountries.eu/rest/v2/all"
        
         Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil)
            .responseJSON {response in
                
                switch response.result
                {
                case .failure(let error):
                    completion(error, nil)
                    print(error)
                    
                case .success(let value):
                    let json = JSON(value)
                    
                    guard let dataArr = json.array  else {
                        completion(nil, nil)
                        return
                    }
                    var countries = [Country]()
                    for data in dataArr {
                        guard let  data = data.dictionary else {return}
                        
                        let country = Country()
                        
                        country.countryName = data["name"]?.stringValue ?? "Country name"
                        

                        countries.append(country)
                    }
                    completion(nil, countries)
                }
        }
    }
    @IBAction func logoutPressed(_ sender: UIBarButtonItem) {
        try! Auth.auth().signOut()
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let LoginViewController = storyBoard.instantiateViewController(withIdentifier: "login") as! LoginViewController
        self.present(LoginViewController,animated: true , completion: nil)
        
    }
    
}
