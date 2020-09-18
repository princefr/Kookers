//
//  BigStarIcon.swift
//  Kookers
//
//  Created by prince ONDONDA on 10/09/2020.
//  Copyright © 2020 prince ONDONDA. All rights reserved.
//

import SwiftUI

struct BigStarIcon: View {
    var filled: Bool = false
    var body: some View {
        Image(systemName: filled ? "star.fill" : "star")
        .foregroundColor(filled ? Color.yellow : Color.black.opacity(0.6))
            .font(.largeTitle)
        
    }
}

struct BigStarIcon_Previews: PreviewProvider {
    static var previews: some View {
        BigStarIcon()
    }
}
