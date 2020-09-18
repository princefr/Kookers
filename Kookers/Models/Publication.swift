//
//  Publiccation.swift
//  Kookers
//
//  Created by prince ONDONDA on 31/08/2020.
//  Copyright © 2020 prince ONDONDA. All rights reserved.
//

import SwiftUI
import Combine
import FirebaseStorage
import Firebase


class Publication: ObservableObject, Codable, Identifiable {
    @Published var uid: String
    @Published var title: String
    @Published var description: String
    @Published var type: SellingType
    @Published var food_preferences: [FoodPreferences]
    @Published var price_all: String
    @Published var price_per_pie: String
    @Published var Adresse: String
    @Published var SellerID: String
    @Published var is_open: Bool
    @Published var geo_hash: String
    @Published var images_urls: [String]
    @Published var images: [UIImage] = [UIImage(named: "placeholder.png")!, UIImage(named: "placeholder.png")!, UIImage(named: "placeholder.png")!]
    
    
    init() {
        self.uid = ""
        self.title = ""
        self.description = ""
        self.type = .plates
        self.food_preferences = all_food_preferences
        self.price_all = ""
        self.price_per_pie = ""
        self.Adresse = ""
        self.SellerID = ""
        self.is_open = true
        self.geo_hash = ""
        self.images_urls = [String]()
    }
    
    init(uid: String, title: String, description: String, type: SellingType, food_preferences: [FoodPreferences], price_all: String, price_per_pie: String, sdresse: String, sellerID: String, is_open: Bool, geo_hash: String, images_urls: [String]) {
        self.uid = uid
        self.title = title
        self.description = description
        self.type = type
        self.food_preferences = food_preferences
        self.price_all = price_all
        self.price_per_pie = price_per_pie
        self.Adresse = sdresse
        self.SellerID = sellerID
        self.is_open = is_open
        self.geo_hash = geo_hash
        self.images_urls = images_urls
    }
    
    enum CodingKeys: String, CodingKey {
        case uid, title, description, type, food_preferences, price_all, price_per_pie, Adresse, SellerID, is_open, geo_hash, images_urls
    }
    
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        uid = try container.decode(String.self, forKey: .uid)
        title = try container.decode(String.self, forKey: .title)
        description = try container.decode(String.self, forKey: .description)
        type = try container.decode(SellingType.self, forKey: .type)
        food_preferences = try container.decode([FoodPreferences].self, forKey: .food_preferences)
        price_all = try container.decode(String.self, forKey: .price_all)
        price_per_pie = try container.decode(String.self, forKey: .price_per_pie)
        Adresse = try container.decode(String.self, forKey: .Adresse)
        SellerID = try container.decode(String.self, forKey: .SellerID)
        is_open = try container.decode(Bool.self, forKey: .is_open)
        geo_hash = try container.decode(String.self, forKey: .geo_hash)
        images_urls = try container.decode([String].self, forKey: .images_urls)
        
        
        
        
    }
    
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(uid, forKey: .uid)
        try container.encode(title, forKey: .title)
        try container.encode(description, forKey: .description)
        try container.encode(type.rawValue, forKey: .type)
        try container.encode(food_preferences, forKey: .food_preferences)
        try container.encode(price_all, forKey: .price_all)
        try container.encode(price_per_pie, forKey: .price_per_pie)
        try container.encode(Adresse, forKey: .Adresse)
        try container.encode(SellerID, forKey: .SellerID)
        try container.encode(is_open, forKey: .is_open)
        try container.encode(geo_hash, forKey: .geo_hash)
        try container.encode(images_urls, forKey: .images_urls)
        
       
    }
    
    
    func loadImage() {
        for imageurl in self.images_urls {
            CachedImage(
                url: imageurl,
                placeholder: Text("Loading ...")
            ).aspectRatio(contentMode: .fit)
        }
    }
    
    

}


enum SellingType: String, Decodable, Equatable, CaseIterable {
    case plates, desserts
    var localizedName: LocalizedStringKey { LocalizedStringKey(rawValue) }
}

