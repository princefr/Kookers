//
//  PriceTextFlied.swift
//  Kookers
//
//  Created by prince ONDONDA on 31/08/2020.
//  Copyright © 2020 prince ONDONDA. All rights reserved.
//

import SwiftUI

struct PriceTextField: View {
    
    @Binding var text_par_part: String
    @Binding var text_par_complet: String
    @Binding var selected_plate_type: SellingType
    
    var body: some View {
         VStack{
            HStack(spacing: 10){
                HStack{
                    Spacer()
                    TextField("Par part", text: $text_par_part)
                    Text("€").foregroundColor(.black)
                }
                
                if selected_plate_type == .desserts  {
                    Divider().frame(height: 25)
                    HStack {
                        Spacer()
                        TextField("Entier", text: $text_par_complet)
                        Text("€").foregroundColor(.black)
                    }
                }
                
            }.padding()
        }.overlay(RoundedRectangle(cornerRadius: 10.0).stroke(lineWidth: 1.0)
            .foregroundColor(Color.gray.opacity(0.5))
            
        )
    }
}

struct PriceTextFlied_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
