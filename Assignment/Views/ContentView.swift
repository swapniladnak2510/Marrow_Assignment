//
//  ContentView.swift
//  Assignment
//
//  Created by Swapnil Adnak on 10/07/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                HStack{
                    Text("MedBook")
                        .font(.largeTitle)
                }
                .padding()
                
                Spacer()
                Image("FlashScreenIcon")
                    .resizable()
                    .frame(width: 250, height: 250)
                Spacer()
                
                HStack(spacing: 20) {
                    NavigationLink {
                       SignupView()
                    } label: {
                        Text("Signup")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    
                    NavigationLink {
                       LoginView()
                    } label: {
                        Text("Login")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(10)
                    }
                }
                .padding()
            }
        }
    }
}


#Preview {
    ContentView()
}
