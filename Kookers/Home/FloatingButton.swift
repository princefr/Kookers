//
//  FloatingButton.swift
//  Kookers
//
//  Created by prince ONDONDA on 31/08/2020.
//  Copyright © 2020 prince ONDONDA. All rights reserved.
//

import SwiftUI

struct FloatingButton: View {
    var floating_clicked: () -> Void
    var body: some View {
        Button(action: floating_clicked, label: {
            Image(systemName: "square.and.pencil")
             .padding(20)
            .background(Color(UIColor(hexString: "F95F5F")))
                .clipShape(Circle())
                .font(.title)
            .foregroundColor(Color.white)
            
        })
    }
}

struct FloatingButton_Previews: PreviewProvider {
    static var previews: some View {
        FloatingButton(){
            print("yep")
        }
    }
}
