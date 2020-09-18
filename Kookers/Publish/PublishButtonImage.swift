//
//  PublishButtonImage.swift
//  Kookers
//
//  Created by prince ONDONDA on 02/09/2020.
//  Copyright © 2020 prince ONDONDA. All rights reserved.
//

import SwiftUI

struct PublishButtonImage: View {
    @Binding var placeholder: UIImage
    @Binding var image_1: UIImage?
    var action: ()->Void
    var body: some View {
          Button(action: action) {
             Image(uiImage: image_1 ?? placeholder)
                 .renderingMode(.original)
                 .resizable()
                 .scaledToFill()
                 .cornerRadius(10)
                 .frame(width: 100, height: 100)
                 .frame(maxWidth: 100, maxHeight: 100)
                 
         }.cornerRadius(10)
          .padding(10)
    }
}


