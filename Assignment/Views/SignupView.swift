//
//  SignupView.swift
//  Assignment
//
//  Created by Swapnil Adnak on 10/07/24.
//

import SwiftUI
import Foundation

struct SignupView: View {
    @ObservedObject  var signupStore = SignupStore()
    
    @State private var userName: String = ""
    @State private var password: String = ""
    @State private var isShowingHomeView = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 1.0) {
                VStack(alignment: .leading) {
                    HStack {
                        Text("Welcome")
                            .font(.largeTitle)
                            .bold()
                        Spacer()
                    }
                    .padding()
                    
                    HStack {
                        Text("Sign up to continue")
                            .font(.headline)
                        Spacer()
                    }
                    .padding()
                }
                
                TextField("Email", text: $userName)
                    .keyboardType(.emailAddress)
                    .padding(.horizontal)
                    .padding(.vertical, 12)
                    .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.black, lineWidth: 1).foregroundColor(Color.black))
                    .padding()
                
                SecureField("Password", text: $password)
                    .padding(.horizontal)
                    .padding(.vertical, 12)
                    .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.black, lineWidth: 1).foregroundColor(Color.black))
                    .padding()
                
                passwordValidationView
                
                if signupStore.errorMessage == nil {
                    countryPicker
                } else {
                    Text(signupStore.errorMessage ?? "")
                        .foregroundStyle(.red)
                }
              
                Spacer()
                
                Button {
                    UserDefaults.standard.setValue($userName.wrappedValue, forKey: "userName")
                    UserDefaults.standard.setValue($password.wrappedValue, forKey: "password")
                    UserDefaults.standard.setValue(signupStore.defaultCountry, forKey: "country")
                    isShowingHomeView.toggle()
                } label: {
                    Text("Let's go")
                        .font(.headline)
                        .foregroundColor(isDisabled() ? nil : .white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .fullScreenCover(isPresented: $isShowingHomeView) {
                    HomeView()
                }
                .disabled(isDisabled())
                .padding()
            }
            .onAppear {
                if let countryList = UserDefaults.standard.object(forKey: "countryList"),
                   let defaultCountry = UserDefaults.standard.object(forKey: "defaultCountry") {
                    signupStore.countryList = (countryList as? [String]) ?? []
                    signupStore.defaultCountry = (defaultCountry as? String) ?? ""
                } else {
                    signupStore.fetchCountryInfo()
                }
            }
        }
    }
    
    private var passwordValidationView: some View {
        ForEach(signupStore.passwordRules, id:\.self) { rule in
            HStack(alignment: .firstTextBaseline) {
                Image(systemName: getValidationImage(rule: rule))
                Text(rule)
            }
            .padding(.top)
            .padding(.leading)
        }
    }
    
    private var countryPicker: some View {
        let names = signupStore.countryList
        @State var selectedCountry = signupStore.defaultCountry
        return VStack(spacing: 0) {
            Picker("Select a country", selection: $selectedCountry) {
                ForEach(names, id: \.self) { name in
                    Text(name).tag(name)
                }
            }
            .frame(height: 140)
            .pickerStyle(WheelPickerStyle())
        }
    }
    
    private func getValidationImage(rule: String) -> String {
        
        var systemImageName: String = ""
        
        // Rule 1: Password should be at least 8 characters
        if rule == signupStore.passwordRules[0] {
            if $password.wrappedValue.count < 8 {
                systemImageName = "rectangle"
            } else {
                systemImageName = "checkmark.rectangle.fill"
            }
        }
        
        // Rule 2: Must contain an uppercase letter
        if rule == signupStore.passwordRules[1] {
            if $password.wrappedValue.rangeOfCharacter(from: .uppercaseLetters) == nil {
                systemImageName = "rectangle"
            } else {
                systemImageName = "checkmark.rectangle.fill"
            }
        }
        
        // Rule 3: Contain an special character
        if rule == signupStore.passwordRules[2] {
            let specialCharacterSet = CharacterSet(charactersIn: "!@#$%^&*()_+-=[]{}|;:'\",.<>?/`~")
            if $password.wrappedValue.rangeOfCharacter(from: specialCharacterSet) == nil {
                systemImageName = "rectangle"
            } else {
                systemImageName = "checkmark.rectangle.fill"
            }
        }
        
        // Rule 4: Contain number
        if rule == signupStore.passwordRules[3] {
            let specialCharacterSet = CharacterSet(charactersIn: "0123456789")
            if $password.wrappedValue.rangeOfCharacter(from: specialCharacterSet) == nil {
                systemImageName = "rectangle"
            } else {
                systemImageName = "checkmark.rectangle.fill"
            }
        }
        return systemImageName
    }
    
    private func isDisabled() -> Bool {
        return !(signupStore.isValidEmail(email: $userName.wrappedValue) && $password.wrappedValue.count >= 8 && $password.wrappedValue.rangeOfCharacter(from: .uppercaseLetters) != nil && $password.wrappedValue.rangeOfCharacter(from: CharacterSet(charactersIn: "!@#$%^&*()_+-=[]{}|;:'\",.<>?/`~")) != nil && $password.wrappedValue.rangeOfCharacter(from: CharacterSet(charactersIn: "0123456789")) != nil)
    }
}

#Preview {
    SignupView()
}
