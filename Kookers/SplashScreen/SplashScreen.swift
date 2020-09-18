//
//  SplashScreen.swift
//  Kookers
//
//  Created by prince ONDONDA on 27/08/2020.
//  Copyright © 2020 prince ONDONDA. All rights reserved.
//

import SwiftUI

struct SplashScreen: View {
    var body: some View {
        VStack {
            Spacer()
            HStack{
                Spacer()
                Image("kookers_logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .scaledToFit()
                Spacer()
            }
            Spacer()
        }.background(Color.white)
        .edgesIgnoringSafeArea(.all)
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
