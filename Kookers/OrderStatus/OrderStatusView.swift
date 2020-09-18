//
//  OrderStatusView.swift
//  Kookers
//
//  Created by prince ONDONDA on 10/09/2020.
//  Copyright © 2020 prince ONDONDA. All rights reserved.
//

import SwiftUI

struct OrderStatusView: View {
    @State var orderstate: OrderState = .not_accepted
    var body: some View {
        VStack {
            HStack (spacing: 10) {
                Image(systemName: "clock")
                    .foregroundColor(.white)
                    
                
                Text("sdsdsd")
                    .font(Font.custom("Saira-Light", size: 15))
                    .foregroundColor(.white)
            }.padding([.leading, .trailing], 10)
        }.padding(3)
        .clipShape(Rectangle())
        .cornerRadius(10).background(Color(UIColor(hexString: "F95F5F")))
         
    }
}




struct OrderStatusView_Previews: PreviewProvider {
    static var previews: some View {
        OrderStatusView()
    }
}
