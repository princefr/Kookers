//
//  RadioSwitch.swift
//  Kookers
//
//  Created by prince ONDONDA on 28/08/2020.
//  Copyright © 2020 prince ONDONDA. All rights reserved.
//

import SwiftUI


struct RadioSwitch: View {
    @ObservedObject var country: Country
    @State var action: () -> Void
    
    var body: some View {
        Button(action: self.action) {
            HStack{
                Image(uiImage: UIImage(named: "CountryPicker.bundle/\(country.code).png")!)
                    .renderingMode(.original)
                    .interpolation(.none)
                    .scaledToFit()
                    
                
                Text(country.id)
                
                Spacer()
                ZStack{
                    Circle().fill(country.is_selected ? Color(UIColor(hexString: "F95F5F")) : Color.black.opacity(0.2)).frame(width: 18, height: 18)
                    if country.is_selected == true {
                        Circle().stroke(Color(UIColor(hexString: "F95F5F")), lineWidth: 2).frame(width: 20, height: 20)
                    }
                }
            }.padding(5)
            
        }.buttonStyle(DefaultButtonStyle())

    }
}
