//
//  PhoneCodeTextView.swift
//  Kookers
//
//  Created by prince ONDONDA on 28/08/2020.
//  Copyright © 2020 prince ONDONDA. All rights reserved.
//

import SwiftUI

struct PhoneCodeTextView: View {
    @Binding var text: String
    @Binding var number_: String
    @Binding var codeSent: Bool
    @Binding var button_code_text : String
    
    var action: () -> Void
    
    var body: some View {
        VStack {
            HStack(spacing: 10) {
                TextField("Code", text: $text)
                    .keyboardType(.numberPad)
                    .padding(.leading, 10)
                
                Button(action: action) {
                    Text(button_code_text)
                        .foregroundColor(Color.white)
                    .font(Font.custom("Saira-Bold", size: 13))
                    .padding()
                }
                .disabled(number_.isEmpty || codeSent ? true: false)
                .background(number_.isEmpty || codeSent ? Color.gray : Color(UIColor(hexString: "F95F5F")))
                .cornerRadius(10, corners: [.topRight, .bottomRight])

                
            }.background(Color.white)
            .clipShape(Rectangle())
            
        }.background(Color.gray.opacity(0.3))
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 0)
        .padding(.leading)
        .padding(.trailing)
    }
}

struct PhoneCodeTextView_Previews: PreviewProvider {
    @State static var this_text: String = ""
    @State static var number_: String = ""
    @State static var codeSent: Bool = false
    @State static var button_code_text : String = "Envoyer le code"
    static var previews: some View {
        PhoneCodeTextView(text: $this_text, number_: $number_, codeSent: $codeSent, button_code_text: $button_code_text){
            print("button clicked")
        }
    }
}
