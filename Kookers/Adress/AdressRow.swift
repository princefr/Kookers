//
//  AdressRow.swift
//  Kookers
//
//  Created by prince ONDONDA on 29/08/2020.
//  Copyright © 2020 prince ONDONDA. All rights reserved.
//

import SwiftUI
import MapKit

struct AdressRow: View {
    @ObservedObject var adress: MKLocalSearchCompletion
    var action: () -> Void
    var body: some View{
        Button(action: self.action) {
            VStack(alignment: .leading) {
                Text(adress.title)
                Text(adress.subtitle)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
    }
}
