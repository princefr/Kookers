//
//  FiveStarPanelView.swift
//  Kookers
//
//  Created by prince ONDONDA on 10/09/2020.
//  Copyright © 2020 prince ONDONDA. All rights reserved.
//

import SwiftUI

struct FiveStarPanelView: View {
    @State var stars:Int = 0
    @State var stars_text: String = "4.7 (675)"
    var body: some View {
        HStack(alignment: .center, spacing: 4) {
            StarIcon(filled: self.stars > 0)
            StarIcon(filled: self.stars > 1)
            StarIcon(filled: self.stars > 2)
            StarIcon(filled: self.stars > 3)
            StarIcon(filled: self.stars > 4)
                Text(stars_text).fontWeight(.light)
                    .font(.caption)
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

struct FiveStarPanelView_Previews: PreviewProvider {
    static var previews: some View {
        FiveStarPanelView()
    }
}
