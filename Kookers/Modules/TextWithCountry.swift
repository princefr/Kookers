//
//  TextWithCountry.swift
//  Kookers
//
//  Created by prince ONDONDA on 28/08/2020.
//  Copyright © 2020 prince ONDONDA. All rights reserved.
//

import SwiftUI

struct TextWithCountry: View {
    @Binding var text: String
    @Binding var current_country: Country
    var action: () -> Void
    var body: some View {
        VStack {
            HStack (spacing: 15) {
                Button(action: action) {
                    HStack(spacing: 5) {
                        Image(uiImage: UIImage(named: "CountryPicker.bundle/\(self.current_country.code).png")!)
                            .renderingMode(.original)
                            .scaledToFit()
                        
                        Text("\(self.current_country.dialcode) ")
                        
                        Image(systemName: "chevron.down")
                            .foregroundColor(.gray)
                    }
                }
                
                Divider().frame(height: 30)
                
                
                TextField("Numéro de téléphone", text: $text).keyboardType(.numberPad)
                
            }.padding(.vertical,12)
            .padding(.horizontal)
            .background(Color.white)
            .clipShape(Rectangle())
            .cornerRadius(5)
            
        }.background(Color.gray.opacity(0.3))
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 0)
        .padding(.leading)
        .padding(.trailing)
    }
}

struct TextWithCountry_Previews: PreviewProvider {
    @State static var  text = ""
    @State static var chosed_country: Country = Country(id: "France", dialcode: "+33", code: "FR")
    static var previews: some View {
        TextWithCountry(text: $text, current_country: $chosed_country) {
            print("")
        }
    }
}
