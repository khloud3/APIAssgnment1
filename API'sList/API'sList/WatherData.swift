//
//  MotorRacing.swift
//  API'sList
//
//  Created by khloud on 10/11/1444 AH.
//

import SwiftUI

struct Welcome2: Codable {
    let weather: [Weather]
}


struct Weather: Codable, Identifiable{
    let main: String
    let description: String
    
    
    var id: String {
        main + description
    }
    
}


struct WeatherData: View {
    @State private var weathers = [Weather]()
    
    var body: some View {
        List(weathers) { weather  in
            VStack{
                Text(weather.description)
                Text(weather.main)
                
            }
        }
        .task {
            await loadData()
        }
        
    }
    
    func loadData() async{
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=44.34&lon=10.99&appid=5a8cb6bd53c82adf23a5a4520f8c169c") else{
            print("OH ... URL NOT WOK")
            
            return
        }
        do{
            let (data ,_) = try await URLSession.shared.data(from: url)
            
            if let dataAsString = String(data: data, encoding: .utf8) {
                print("Data as string: \(dataAsString)")
            }
            
            let serverData = try JSONDecoder().decode(Welcome2.self, from: data)
           
            weathers = serverData.weather
            
        } catch {
            print("ERROR \(error)")
            
        }
    }
    
}



struct WeatherData_Previews: PreviewProvider {
    static var previews: some View {
        WeatherData()
    }
}
