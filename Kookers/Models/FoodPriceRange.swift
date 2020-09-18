//
//  FoodPriceRange.swift
//  Kookers
//
//  Created by prince ONDONDA on 30/08/2020.
//  Copyright © 2020 prince ONDONDA. All rights reserved.
//

import SwiftUI

class FoodPriceRange : ObservableObject, Identifiable, Codable  {
   @Published var id : Int
   @Published var title : String
   @Published var is_selected : Bool
    
    init(id: Int, title: String, is_selected: Bool) {
        self.id = id
        self.title = title
        self.is_selected = is_selected
    }
    
    func toogle() {
        self.is_selected.toggle()
    }
    
    
    func set_to_false(){
        self.is_selected = false
    }
    
    
    enum CodingKeys: String, CodingKey {
        case id, title, is_selected
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        is_selected = try container.decode(Bool.self, forKey: .is_selected)
    }
    
    func encode(to encoder: Encoder) throws  {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(is_selected, forKey: .is_selected)
    }
    
}


var all_price_range = [
    FoodPriceRange(id: 0 , title: "€", is_selected: false),
    FoodPriceRange(id: 1 , title: "€€", is_selected: false),
    FoodPriceRange(id: 2 , title: "€€€", is_selected: false),
    FoodPriceRange(id: 3 , title: "€€€€", is_selected: false)
]
