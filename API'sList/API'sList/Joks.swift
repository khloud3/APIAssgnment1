//
//  Joks.swift
//  API'sList
//
//  Created by khloud on 10/11/1444 AH.
//

import SwiftUI
struct Jokes :Codable {
    var id : Int
    let type : String
    let setup :String
    let punchline : String
    
}
struct Joks: View {
    @State private var joke = Jokes(id: 1, type: "", setup: "", punchline: "")
    var body: some View {
      
            VStack(spacing: 50){
                Text(joke.type)
                    .background(Color(.orange))
                    .cornerRadius(5)
                    .font(.title)
                    .foregroundColor(.white)
                Text(joke.setup)
                    .font(.system(size: 20))
                Text(joke.punchline)
                    .font(.system(size: 20))
                    .foregroundColor(.indigo)
                
                Text(" 🤪 🤣")
                    
                
            }.padding()
            
            .task {
            await loadData()
        }
    }
    
    func loadData() async{
        guard let url = URL(string: "https://official-joke-api.appspot.com/random_joke") else{
            print("OH ... URL NOT WOK")
            
            return
        }
        do{
            let (data , _) = try await URLSession.shared.data(from: url)
           
            let serverData = try JSONDecoder().decode(Jokes.self, from: data)
                joke = serverData
            
            
        }catch {
            print("ERROR \(error)")
            
        }
    }
}

struct Joks_Previews: PreviewProvider {
    static var previews: some View {
        Joks()
    }
}
