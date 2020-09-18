//
//  FoodPreferences.swift
//  Kookers
//
//  Created by prince ONDONDA on 28/08/2020.
//  Copyright © 2020 prince ONDONDA. All rights reserved.
//

import SwiftUI

class FoodPreferences : ObservableObject, Identifiable, Codable, Equatable {
   @Published var id : Int
   @Published var title : String
   @Published var is_selected : Bool
    
    init(id: Int, title: String, is_selected: Bool) {
        self.id = id
        self.title = title
        self.is_selected = is_selected
    }
    
    static func == (lhs: FoodPreferences, rhs: FoodPreferences) -> Bool {
        return lhs.id == rhs.id && rhs.is_selected == rhs.is_selected
    }
    
    func toogle(){
        self.is_selected.toggle()
    }
    
    
    func set_to_false(){
        self.is_selected = false
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case is_selected
    }
    
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        is_selected = try container.decode(Bool.self, forKey: .is_selected)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(is_selected, forKey: .is_selected)
    }
}

var all_food_preferences = [
    FoodPreferences(id: 0 , title: "Végétarien", is_selected: false),
    FoodPreferences(id: 1 , title: "Vegan", is_selected: false),
    FoodPreferences(id: 2 , title: "Sans gluten", is_selected: false),
    FoodPreferences(id: 3 , title: "Hallal", is_selected: false),
    FoodPreferences(id: 4 , title: "Adapté aux allergies alimentaires", is_selected: false)
]



