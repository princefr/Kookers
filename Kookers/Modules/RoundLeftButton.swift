//
//  RoundLeftButton.swift
//  Kookers
//
//  Created by prince ONDONDA on 27/08/2020.
//  Copyright © 2020 prince ONDONDA. All rights reserved.
//

import SwiftUI

struct RoundLeftButton: View {
    @State var button_text: String
    var action: () -> Void
    var body: some View {
        Button(action: action) {

            Text(button_text)
                .foregroundColor(Color.white)
                .fontWeight(.bold)
                .padding()
            
        }.background(Color(UIColor(hexString: "F95F5F")))
            
        .cornerRadius(30, corners: [.topLeft])
        
    }
}

struct RoundLeftButton_Previews: PreviewProvider {
    @State static var button_text = "Publier"
    static var previews: some View {
        RoundLeftButton(button_text: button_text){
            print("this is is ")
        }
    }
}


extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}


struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
