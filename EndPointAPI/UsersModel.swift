//
//  SwiftUIView.swift
//  EndPointAPI
//
//  Created by Mohammad Muksith on 3/22/23.
//

import SwiftUI

@MainActor
class UsersModel: ObservableObject{
    @Published var users: [Users] = []
    func reload() async {
        let url = URL(string: "https://random-data-api.com/api/v2/users?size=10")!
        let urlSession = URLSession.shared
        do {
            let (data, _) = try await urlSession.data(from: url)
            self.users = try JSONDecoder().decode([Users].self, from: data)
        }
        catch {
            debugPrint("Error loading \(url): \(String(describing: error))")
        }
    }
}
