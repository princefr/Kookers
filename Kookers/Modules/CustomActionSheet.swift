//
//  CustomActionSheet.swift
//  Kookers
//
//  Created by prince ONDONDA on 14/09/2020.
//  Copyright © 2020 prince ONDONDA. All rights reserved.
//

import SwiftUI

struct CustomActionSheet: View {
    @Binding var date: Date
    var action: () -> Void
    @State var button_state: RoundedButtonState = .inactive
    @State var button_text: String = "Choisir la periode"
    @State var loading_text: String = "Chargement"
    var body: some View {
        VStack (alignment: .leading, spacing: 10) {
            Text("Choisir une date :").font(.custom("Saira-light", size: 20))
            DatePicker(selection: self.$date, in: Date()..., displayedComponents: [.date, .hourAndMinute]) {
                EmptyView()
            }.frame(maxHeight: 300)
            
            HStack {
                Spacer()
                RoundedButtonView(action: action, button_state: self.$button_state, inactive_text: self.$button_text, loading_text: self.$loading_text)
                Spacer()
            }
            
        }.padding(.bottom, (UIApplication.shared.windows.last?.safeAreaInsets.bottom)! + 10)
        .padding(.horizontal)
        .padding(.top, 10)
        .background(Color(UIColor.systemBackground))
        .cornerRadius(15)
    }
}

struct CustomActionSheet_Previews: PreviewProvider {
    @State static var date: Date = Date()
    static var previews: some View {
        CustomActionSheet(date: $date, action: {
            print("i chood my shite")
        })
    }
}
