//
//  SignupStore.swift
//  Assignment
//
//  Created by Swapnil Adnak on 10/07/24.
//

import Foundation

public class SignupStore: ObservableObject {
    @Published var countryList: [String] = []
    @Published var defaultCountry: String = ""
    @Published var errorMessage: String? = nil
    
    
    private var countriesInfo: CountryModel? = nil
    let passwordRules = [
        "At least 8 characters",
        "Must contain an uppercase letter",
        "Must contain an special character",
        "Must contain a number"
    ]
    
    public func fetchCountryInfo() {
        let url = URL(string: "https://api.first.org/data/v1/countries")
        
        URLSession.shared.dataTask(with: url!) { [weak self] data, response, error in
            if let data, error == nil {
                if let countryModel = try? JSONDecoder().decode(CountryModel.self, from: data) {
                    self?.countriesInfo = countryModel
                    self?.fetchCountryCodeFromIP()
                }
            } else {
                self?.errorMessage = "Error fetching country information"
            }
        }
        .resume()
    }
    
    private func fetchCountryCodeFromIP() {
        let url = URL(string: "https://ipapi.co/json/")
        var list: [String] = []
        URLSession.shared.dataTask(with: url!) { [weak self] data, response, error in
            if let data, error == nil {
                let countryCode = try? JSONDecoder().decode(IPModel.self, from: data)
                if let countriesInfo = self?.countriesInfo?.data {
                    for (_, y) in countriesInfo {
                        list.append(y.country)
                    }
                }
                DispatchQueue.main.async {
                    if let countryCode = countryCode?.country {
                        self?.defaultCountry = self?.countriesInfo?.data[countryCode]?.country ?? ""
                        self?.countryList = list
                        UserDefaults.standard.setValue(list, forKey: "countryList")
                        UserDefaults.standard.setValue(self?.defaultCountry, forKey: "defaultCountry")
                    }
                }
            } else {
                self?.errorMessage = "Error fetching country code from IP"
            }
        }
        .resume()
    }
    
    func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return predicate.evaluate(with: email)
    }
}
