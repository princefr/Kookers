//
//  Adress.swift
//  Kookers
//
//  Created by prince ONDONDA on 30/08/2020.
//  Copyright © 2020 prince ONDONDA. All rights reserved.
//

import SwiftUI
import CoreLocation

class AdressModel: ObservableObject, Identifiable, Codable {
    @Published var Title: String
    @Published var SubTitle: String
    @Published var complete_adress: String
    @Published var lat: Double
    @Published var long: Double
    @Published var is_choosed: Bool = false
    

    enum CodingKeys: String, CodingKey {
        case Title
        case SubTitle
        case complete_adress
        case lat
        case long
        case is_choosed
    }
    
    
    func toogle() {
        self.is_choosed.toggle()
    }
    
    
    func set_to_false(){
        self.is_choosed = false
    }
    

    
    
    init(title: String, subtitle: String, lat: Double, long: Double, ischoosed: Bool) {
        self.Title = title
        self.SubTitle =  subtitle
        self.lat = lat
        self.long = long
        self.is_choosed = ischoosed
        self.complete_adress = title + " ," + subtitle
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        Title = try container.decode(String.self, forKey: .Title)
        SubTitle = try container.decode(String.self, forKey: .SubTitle)
        lat = try container.decode(Double.self, forKey: .lat)
        long = try container.decode(Double.self, forKey: .long)
        is_choosed = try container.decode(Bool.self, forKey: .is_choosed)
        complete_adress = try container.decode(String.self, forKey: .complete_adress)
        
    }
    
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(Title, forKey: .Title)
        try container.encode(SubTitle, forKey: .SubTitle)
        try container.encode(lat, forKey: .lat)
        try container.encode(long, forKey: .long)
        try container.encode(is_choosed, forKey: .is_choosed)
        try container.encode(complete_adress, forKey: .complete_adress)
        
    }

}

