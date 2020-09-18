//
//  BigFiveStartView.swift
//  Kookers
//
//  Created by prince ONDONDA on 10/09/2020.
//  Copyright © 2020 prince ONDONDA. All rights reserved.
//

import SwiftUI

struct BigFiveStartView: View {
    @State var stars:Int = 0
    var body: some View {
        HStack(alignment: .center, spacing: 4) {
            BigStarIcon(filled: self.stars > 0)
            BigStarIcon(filled: self.stars > 1)
            BigStarIcon(filled: self.stars > 2)
            BigStarIcon(filled: self.stars > 3)
            BigStarIcon(filled: self.stars > 4)
            }
            .padding(.all, 12)
            .background(Color.white)
            .cornerRadius(10)
            //.shadow(color: Color.black.opacity(0.1), radius: 20, x: 0, y: 0)
            .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local).onChanged({ val in
                let percent = max((val.location.x / 110.0), 0.0)
                self.stars = min(Int(percent * 5.0) + 1, 5)
            }).onEnded({ val in
                let percent = max((val.location.x / 110.0), 0.0)
                self.stars = min(Int(percent * 5.0) + 1, 5)
            }))
    }
}

struct BigFiveStartView_Previews: PreviewProvider {
    static var previews: some View {
        BigFiveStartView()
    }
}
