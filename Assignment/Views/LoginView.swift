//
//  LoginView.swift
//  Assignment
//
//  Created by Swapnil Adnak on 10/07/24.
//

import SwiftUI

struct LoginView: View {
    @State private var userName: String = ""
    @State private var password: String = ""
    @State private var isShowingHomeView = false
    @State private var errorMessage = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Welcome")
                    .font(.largeTitle)
                    .bold()
                Spacer()
            }
            .padding()
            
            HStack {
                Text("Log in to continue")
                    .font(.headline)
                Spacer()
            }
            .padding()
           
            TextField("Email", text: $userName)
                .keyboardType(.emailAddress)
                .padding(.horizontal)
                .padding(.vertical, 12)
                .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.black, lineWidth: 1).foregroundColor(Color.black))
                .padding()
            
            TextField("Password", text: $password)
                .padding(.horizontal)
                .padding(.vertical, 12)
                .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.black, lineWidth: 1).foregroundColor(Color.black))
                .padding()
            HStack {
                Spacer()
                Text($errorMessage.wrappedValue)
                    .font(.caption)
                    .foregroundColor(.red)
                Spacer()
            }
            
            Spacer()
            
            Button {
                if let user = UserDefaults.standard.object(forKey: "userName") as? String,
                   let password = UserDefaults.standard.object(forKey: "password") as? String {
                    if user == $userName.wrappedValue && password == $password.wrappedValue {
                        isShowingHomeView.toggle()
                    } else {
                        errorMessage = "Wrong username or password"
                    }
                } else {
                    errorMessage = "Please do registration first"
                }
            } label: {
                Text("Login")
                    .font(.headline)
                    .foregroundColor(($userName.wrappedValue.isEmpty || $password.wrappedValue.isEmpty) ? nil : .white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .disabled(($userName.wrappedValue.isEmpty || $password.wrappedValue.isEmpty))
            .fullScreenCover(isPresented: $isShowingHomeView) {
                HomeView()
            }
            .padding()
        }
    }
}

#Preview {
    LoginView()
}
