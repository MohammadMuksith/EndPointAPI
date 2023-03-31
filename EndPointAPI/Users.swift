//
//  Users.swift
//  EndPointAPI
//
//  Created by Mohammad Muksith on 3/23/23.
//

import SwiftUI

struct Users: Identifiable, Codable, Hashable{
    var id: Int
    var password: String
    var first_name: String
    var last_name: String
    var fullname : String{
        self.first_name + self.last_name
    }
    var username: String
    var email: String
    var avatar: URL
    var phone_number: String
    var date_of_birth: String
}
