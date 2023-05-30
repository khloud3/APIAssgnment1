//
//  Book.swift
//  API'sList
//
//  Created by khloud on 10/11/1444 AH.
//

import SwiftUI

struct Welcome: Codable {
    let results: [Result]
}

struct Name : Codable {
    let title :String
    let first : String
    let last : String
}

struct Result :Codable, Identifiable{
    let name : Name
    let gender : String
    let email: String
    let phone: String
    
    var id : String{
        name.title + name.first + name.last
    }
    
}

struct Users: View {
    @State private var user = [Result]()
    
    var body: some View {
        List(user) { result in
            VStack{
                HStack{
                    Text("Name :")
                    Text(result.name.title)
                    Text(result.name.first + " " + result.name.last )
                }
                
                Spacer()
                HStack{
                    Text("Gender :")
                    Text(result.gender)
                }
                Spacer()
                HStack{
                    
                    Text("Contact Info :")
                    Text(result.phone)
                    
                }
                
                Text(result.email)
            }.padding()
            
        }.task {
            await loadData()
        }
    }
    
    func loadData() async{
        guard let url = URL(string: "https://randomuser.me/api/") else{
            print("OH ... URL NOT WOK")
            
            return
        }
        do{
            let (data , _) = try await URLSession.shared.data(from: url)
            
            if let dataAsString = String (data: data, encoding: .utf8){
                print("Data as String:\(dataAsString)")
            }
            
            let serverData = try JSONDecoder().decode(Welcome.self, from: data)
            user = serverData.results
            
            
        }catch {
            print("ERROR \(error)")
            
        }
    }
}

struct Users_Previews: PreviewProvider {
    static var previews: some View {
        Users()
    }
}
