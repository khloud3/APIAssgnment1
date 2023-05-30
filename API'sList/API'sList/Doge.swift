//
//  Doge.swift
//  API'sList
//
//  Created by khloud on 10/11/1444 AH.
//

import SwiftUI

struct DogImage: Codable {
  
    let message: String
    let status : String
}

struct Doge: View {
    @State private var dogImage = DogImage(message: "", status: "")
    
    var body: some View {
        VStack{
            
         AsyncImage (url : URL (string : dogImage.message))
            
            Text(dogImage.status)
        }
        .task {
            await loadData()
        }
    }
    
    func loadData() async{
        guard let url = URL(string: "https://dog.ceo/api/breeds/image/random") else{
            print("OH ... URL NOT WOK")
            return
        }
        
        do {
            let (data , _) = try await URLSession.shared.data(from: url)
            
            let serverdata = try JSONDecoder().decode(DogImage.self, from: data)
            dogImage = serverdata
            
            
        } catch {
            print("ERROR \(error)")
        }
    }
    
}
struct Doge_Previews: PreviewProvider {
    static var previews: some View {
        Doge()
    }
}
