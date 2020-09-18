//
//  AdressSwitch.swift
//  Kookers
//
//  Created by prince ONDONDA on 31/08/2020.
//  Copyright © 2020 prince ONDONDA. All rights reserved.
//

import SwiftUI

struct AdressSwitch: View {
    @ObservedObject var adress: AdressModel
    @State var action: () -> Void
    var body: some View {
        Button(action: action, label: {
            HStack {
                VStack (alignment: .leading, spacing: 10) {
                    Text(adress.Title)
                    Text(adress.complete_adress)
                }
                
                Spacer()
                ZStack{
                    Circle().fill(adress.is_choosed ? Color(UIColor(hexString: "F95F5F")) : Color.black.opacity(0.2)).frame(width: 15, height: 15)
                    if adress.is_choosed == true {
                        Circle().stroke(Color(UIColor(hexString: "F95F5F")), lineWidth: 2).frame(width: 20, height: 20)
                    }
                }
            }.padding(5)
        }).buttonStyle(DefaultButtonStyle())
    }
}

struct AdressSwitch_Previews: PreviewProvider {
    static var previews: some View {
       // AdressSwitch()
        EmptyView()
    }
}

