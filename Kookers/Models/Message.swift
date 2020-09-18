//
//  Message.swift
//  Kookers
//
//  Created by prince ONDONDA on 01/09/2020.
//  Copyright © 2020 prince ONDONDA. All rights reserved.
//

import SwiftUI

class Message: ObservableObject, Identifiable, Codable {
    @Published var uid: String
    @Published var createdAt: Date
    @Published var message : String
    @Published var profilePic : String
    @Published var message_picture: Data?
    
    
    init(uid: String, createdAt: Date, message: String, profilepic: String, message_picture: Data?) {
        self.uid = uid
        self.createdAt = createdAt
        self.message = message
        self.profilePic = profilepic
        self.message_picture = message_picture
    }
    
    
    enum CodingKeys: String, CodingKey {
        case uid, createdAt, message, profilePic, message_picture
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        uid = try container.decode(String.self, forKey: .uid)
        createdAt = try container.decode(Date.self, forKey: .createdAt)
        message = try container.decode(String.self, forKey: .message)
        profilePic = try container.decode(String.self, forKey: .profilePic)
        message_picture = try container.decode(Data.self, forKey: .message_picture)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(uid, forKey: .uid)
        try container.encode(createdAt, forKey: .createdAt)
    }
    
}


class ChatRoom: ObservableObject, Identifiable, Codable {
    @Published var uid: String
    @Published var createdAt: Date
    @Published var updatedAt: Date
    @Published var messages : [Message]
    @Published var users: [String:Bool]
    @Published var notificationCountUser_1: Int
    @Published var notificationCountUser_2: Int
    
    
    init() {
        self.uid = ""
        self.createdAt = Date()
        self.updatedAt = Date()
        self.messages = [Message]()
        self.users = [String:Bool]()
        self.notificationCountUser_1 = 0
        self.notificationCountUser_2 = 0
    }
    
    
    init(uid: String, createdAt: Date, messages: [Message], updateAt: Date, users: [String:Bool], notificationCountUser_1: Int, notificationCountUser_2: Int) {
        self.uid = uid
        self.createdAt = createdAt
        self.messages = messages
        self.updatedAt = updateAt
        self.users = users
        self.notificationCountUser_1 = notificationCountUser_1
        self.notificationCountUser_2 = notificationCountUser_2
    }
    
    enum CodingKeys: String, CodingKey {
        case uid, createdAt, updatedAt, messages, users, notificationCountUser_1, notificationCountUser_2
    }
    
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        uid = try container.decode(String.self, forKey: .uid)
        createdAt = try container.decode(Date.self, forKey: .createdAt)
        messages = try container.decode([Message].self, forKey: .messages)
        updatedAt = try container.decode(Date.self, forKey: .updatedAt)
        users = try container.decode([String:Bool].self, forKey: .users)
        notificationCountUser_1 = try container.decode(Int.self, forKey: .notificationCountUser_1)
        notificationCountUser_2 = try container.decode(Int.self, forKey: .notificationCountUser_2)
    }
    
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(uid, forKey: .uid)
        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(messages, forKey: .messages)
        try container.encode(updatedAt, forKey: .updatedAt)
        try container.encode(users, forKey: .users)
        try container.encode(notificationCountUser_1, forKey: .notificationCountUser_1)
        try container.encode(notificationCountUser_2, forKey: .notificationCountUser_2)
    }
    

}
