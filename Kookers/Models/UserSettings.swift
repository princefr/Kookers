//
//  UserSettings.swift
//  Kookers
//
//  Created by prince ONDONDA on 28/08/2020.
//  Copyright © 2020 prince ONDONDA. All rights reserved.
//

import SwiftUI

class UserSettings: ObservableObject, Codable, Identifiable {
    @Published var food_preferences: [FoodPreferences]
    @Published var food_price_range : [FoodPriceRange]
    @Published var distance_from_seller: Double = 45
    @Published var createdAt: Date?
    @Published var updatedAt: Date?
    @Published var notification_enabled: Bool?
    
    
    init(food_preferences: [FoodPreferences], food_price_range: [FoodPriceRange], createdAt: Date, updatedAt: Date, notification_enabled: Bool) {
        self.food_preferences = food_preferences
        self.food_price_range = food_price_range
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.notification_enabled = notification_enabled
    }
    
    enum CodingKeys: String, CodingKey {
        case food_preferences
        case food_price_range
        case distance_from_seller
        case createdAt
        case updatedAt
        case notification_enabled
    }
    
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        food_preferences = try container.decode([FoodPreferences].self, forKey: .food_preferences)
        food_price_range = try container.decode([FoodPriceRange].self, forKey: .food_price_range)
        distance_from_seller = try container.decode(Double.self, forKey: .distance_from_seller)
        createdAt = try container.decode(Date.self, forKey: .createdAt)
        updatedAt = try container.decode(Date.self, forKey: .updatedAt)
        notification_enabled = try container.decode(Bool.self, forKey: .notification_enabled)
    }
    
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(food_preferences, forKey: .food_preferences)
        try container.encode(food_price_range, forKey: .food_price_range)
        try container.encode(distance_from_seller, forKey: .distance_from_seller)
        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(updatedAt, forKey: .updatedAt)
        try container.encode(notification_enabled, forKey: .notification_enabled)
    }
}

