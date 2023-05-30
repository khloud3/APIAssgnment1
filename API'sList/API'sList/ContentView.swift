//
//  ContentView.swift
//  API'sList
//
//  Created by khloud on 10/11/1444 AH.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationStack {
            TabView {
        
                WeatherData()
                    .tabItem{
                        Text("Weath")
                    }
                
                Doge()
                    .tabItem {
                        Text("Doge")
                    }
                
                Joks()
                    .tabItem {
                        Text("Joks")
                    }

                Users()
                    .tabItem {
                        Text("Users")
                    }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
