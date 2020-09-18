//
//  User.swift
//  Kookers
//
//  Created by prince ONDONDA on 28/08/2020.
//  Copyright © 2020 prince ONDONDA. All rights reserved.
//

import SwiftUI
import Combine

class UserWSell: ObservableObject {
    @Published var uid: String
    @Published var email: String
    @Published var first_name: String
    @Published var last_name: String
    @Published var displayName: String
    @Published var birth_date: Date
    @Published var birth_place: String
    @Published var city: String?
    @Published var zip_code: String?
    @Published var country: String?
    @Published var adress: String
    @Published var phonenumber: String?
    @Published var is_recto_id: Bool?
    @Published var is_verso_id: Bool?
    @Published var website: String?
    @Published var user_qr_code_text: String?
    @Published var is_business: Bool?
    @Published var business_type: Business_type?
    
    init(uid: String, first_name: String, last_name: String, email: String, birth_date: Date, birth_place: String, city: String?, zip_code: String?, country: String?, adress: String, phonenumber: String?, is_recto_id: Bool?, is_verso_id: Bool?, website: String?, user_qr_code_text: String?, is_business: Bool?, business_type: Business_type?) {
         self.uid = uid
         self.email = email
         self.first_name = first_name
         self.last_name = last_name
         self.displayName = first_name + " " + last_name
         self.birth_date = birth_date
         self.birth_place = birth_place
         self.city = city
         self.zip_code = zip_code
         self.country = country
         self.adress = adress
         self.phonenumber = phonenumber
         self.is_recto_id = is_recto_id
         self.is_verso_id = is_verso_id
         self.website = website
         self.user_qr_code_text = user_qr_code_text
         self.is_business = is_business
         self.business_type = business_type
     }
    
    
    enum Business_type {
        case Interprise, Individual, ONG, Public_enterprise, none
    }
}


class User: ObservableObject, Codable, Identifiable {
    @Published var uid: String
    @Published var email: String
    @Published var first_name: String
    @Published var last_name: String
    @Published var displayName: String
    @Published var phonenumber: String
    @Published var settings: UserSettings
    @Published var createdAt : Date?
    @Published var updateAt: Date
    @Published var current_adress: AdressModel
    @Published var all_searched_adresses : [AdressModel]
    @Published var fcmToken: String
    
    init() {
        self.uid = ""
        self.email = ""
        self.first_name = ""
        self.last_name = ""
        self.displayName = ""
        self.phonenumber = ""
        self.settings = UserSettings(food_preferences: all_food_preferences, food_price_range: all_price_range, createdAt: Date(), updatedAt: Date(), notification_enabled: true)
        self.createdAt = Date()
        self.updateAt = Date()
        self.current_adress = AdressModel(title: "", subtitle: "", lat: 0.0, long: 0.0, ischoosed: false)
        self.fcmToken = ""
        self.all_searched_adresses = [AdressModel]()
    }

    init(uid: String?, email: String?, first_name: String?, last_name: String?, display_name: String?, phone_number: String?, Settings: UserSettings?, createdAt: Date?, updateAt: Date?, fcmtok: String?, current_adress: AdressModel?, all_adress: [AdressModel]?) {
        self.uid = uid ?? ""
        self.email = email ?? ""
        self.first_name = first_name ?? ""
        self.last_name = last_name ?? ""
        self.displayName = first_name! + " " + last_name!
        self.phonenumber = phone_number ?? ""
        self.settings = Settings ?? UserSettings(food_preferences: all_food_preferences, food_price_range: all_price_range, createdAt: Date(), updatedAt: Date(), notification_enabled: true)
        self.createdAt = createdAt ?? Date()
        self.updateAt = updateAt ?? Date()
        self.fcmToken = fcmtok ?? ""
        self.current_adress = current_adress ?? AdressModel(title: "", subtitle: "", lat: 0.0, long: 0.0, ischoosed: false)
        self.all_searched_adresses = all_adress ?? [AdressModel]()
    }
    
    
    
    enum CodingKeys: String, CodingKey {
        case uid
        case email
        case first_name
        case last_name
        case displayName
        case phonenumber
        case settings
        case createdAt
        case updatedAt
        case current_adress
        case all_searched_adresses
        case fcmToken
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        uid = try container.decode(String.self, forKey: .uid)
        email = try container.decode(String.self, forKey: .email)
        first_name = try container.decode(String.self, forKey: .first_name)
        last_name = try container.decode(String.self, forKey: .last_name)
        displayName = try container.decode(String.self, forKey: .displayName)
        phonenumber = try container.decode(String.self, forKey: .phonenumber)
        settings = try container.decode(UserSettings.self, forKey: .settings)
        createdAt = try container.decode(Date.self, forKey: .createdAt)
        updateAt = try container.decode(Date.self, forKey: .updatedAt)
        current_adress = try container.decode(AdressModel.self, forKey: .current_adress)
        all_searched_adresses = try container.decode([AdressModel].self, forKey: .all_searched_adresses)
        fcmToken = try container.decode(String.self, forKey: .fcmToken)
    }
    
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(uid, forKey: .uid)
        try container.encode(email, forKey: .email)
        try container.encode(first_name, forKey: .first_name)
        try container.encode(last_name, forKey: .last_name)
        try container.encode(displayName, forKey: .displayName)
        try container.encode(phonenumber, forKey: .phonenumber)
        try container.encode(settings, forKey: .settings)
        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(updateAt, forKey: .updatedAt)
        try container.encode(current_adress, forKey: .current_adress)
        try container.encode(all_searched_adresses, forKey: .all_searched_adresses)
        try container.encode(fcmToken, forKey: .fcmToken)
    }
    
    

    func addNewAdress(adress: AdressModel) {
        if !all_searched_adresses.contains(where: { $0.complete_adress == adress.complete_adress}) {
            _ = all_searched_adresses.map{$0.is_choosed = false}
            all_searched_adresses.append(adress)
        }else{
            _ = all_searched_adresses.map{
                if $0.complete_adress == adress.complete_adress {
                    $0.is_choosed = true
                }else{
                    $0.is_choosed = false
                }
            }
            
        }
    }
    
    
    
    
    func adress_switch_update(adress: AdressModel){
        adress.is_choosed = true
        current_adress = adress
        _ = all_searched_adresses.map{
            if $0.complete_adress == adress.complete_adress {
                $0.is_choosed = true
            }else{
                $0.is_choosed = false
            }
        }
    }
}
