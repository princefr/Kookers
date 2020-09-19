//
//  PagePhotos.swift
//  Kookers
//
//  Created by prince ONDONDA on 19/09/2020.
//  Copyright © 2020 prince ONDONDA. All rights reserved.
//

import SwiftUI

struct PagePhotos: View {
    @State var url: String
    var body: some View {
        CachedImage(
            url: url,
            placeholder: Image(uiImage: UIImage(named: "placeholder")!)
        ).aspectRatio(contentMode: .fill)
    }
}

struct PagePhotos_Previews: PreviewProvider {
    @State static var url = ""
    static var previews: some View {
        PagePhotos(url: url)
    }
}
