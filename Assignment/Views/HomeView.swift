//
//  HomeView.swift
//  Assignment
//
//  Created by Swapnil Adnak on 11/07/24.
//

import SwiftUI

struct HomeView: View {
    @State private var searchText: String = ""
    
    var body: some View {
        VStack(spacing: 1) {
                HStack {
                    Text("MedBook")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.leading)
                    Spacer()
                    Image(systemName: "bookmark")
                        .font(.title)
                        .padding(.trailing)
                    Image(systemName: "xmark.square")
                        .font(.title)
                        .padding(.trailing)
                }
                .padding(.top, 10)
            HStack {
                Text("Which topic interests you today?")
                    .font(.title2)
                    .fontWeight(.medium)
                    .padding(.top, 20)
                Spacer()
            }
            .padding()
                
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    TextField("Search for books", text: $searchText)
                        .padding(10)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                .padding()
                
                Spacer()
            }
    }
}
#Preview {
    HomeView()
}
