//
//  WalletView.swift
//  Kookers
//
//  Created by prince ONDONDA on 14/09/2020.
//  Copyright © 2020 prince ONDONDA. All rights reserved.
//

import SwiftUI

struct WalletView: View {
    @State var button_state: RoundedButtonState = .inactive
    @State var button_text: String = "Retirer mon argent"
    @State var loading_text: String = "Retrait en cours ..."
    @State var available_money: Float = 2000.54
    var body: some View {
        
        
        VStack {
            
            Spacer().frame(height: 150)
            HStack {
                Text("\(available_money.clean)").font(Font.custom("Saira-Light", size: 40))
                Text("€").font(Font.custom("Saira-Bold", size: 40)).foregroundColor(Color.gray)
            }
            
            Divider()
            
            HStack {
                Image(systemName: "info.circle.fill").foregroundColor(Color.gray)
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam").font(.caption)
            }.padding(10)
            
            Spacer()
            VStack {
                HStack {
                    Spacer()
                    RoundedButtonView(action: {
                        self.button_state = .inprogress
                        //self.upload_publication(pub: self.publication)
                    }, button_state: self.$button_state, inactive_text: self.$button_text, loading_text: self.$loading_text).disabled(self.available_money > 0 ? true: false)
                    Spacer()
                }
            }
        }
    }
}

struct WalletView_Previews: PreviewProvider {
    static var previews: some View {
        WalletView()
    }
}


extension Float {
    var clean: String {
       return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
