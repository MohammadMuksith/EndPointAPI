//
//  ContentView.swift
//  EndPointAPI
//
//  Created by Mohammad Muksith on 3/22/23.
//

import SwiftUI

struct ContentView: View {
    @State private var sheet: Users? = nil
    @StateObject var usersModel = UsersModel()
    @State private var users = [Users]().self
    @State private var searchData = String()
    @State var filteredData = UsersModel().users
    var searchResults: [Users] {
        if searchData.isEmpty{
            return usersModel.users
        }
        else{
            return usersModel.users.filter{
                $0.fullname.localizedCaseInsensitiveContains(searchData)
            }
        }
    }
    var body: some View {
        NavigationView{
            
            List(searchResults) { list in
                HStack{
                    AsyncImage(url: list.avatar, scale: 5)
                        .background(.cyan)
                        .clipShape(Circle())
                        .foregroundColor(.black)
                    Text(list.first_name)
                    Text(list.last_name)
                    Button{
                        sheet = list
                    }
                label:{
                    Image("")
                        .foregroundColor(.blue)
                }
                .sheet(item: $sheet, content:{sheet in
                    VStack(alignment: .center){
                        AsyncImage(url: sheet.avatar, scale: 2)
                        Text("Username: \(sheet.username)")
                            .foregroundColor(.white)
                        Text("Email: \(sheet.email)")
                            .foregroundColor(.white)
                        Text("Password: \(sheet.password)")
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .font(.title2)
                    .background(.cyan)
                })
                
            }
        }
            .task {
                await self.usersModel.reload()
            }
            .refreshable {
                await self.usersModel.reload()
            }
            .navigationTitle("Users")
            .searchable(text: $searchData)
            .background(.blue)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
