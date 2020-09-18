//
//  RatingView.swift
//  Kookers
//
//  Created by prince ONDONDA on 10/09/2020.
//  Copyright © 2020 prince ONDONDA. All rights reserved.
//

import SwiftUI

struct RatingView: View {
    @State var button_text: String = "Noter le plat"
    
    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 20) {
                HStack {
                    Spacer()
                    Rectangle().frame(width: 80, height: 5)
                        .cornerRadius(10)
                        .padding(.top, 10)
                        .foregroundColor(Color.gray)
                    Spacer()
                }
                
                Spacer().frame(height: 100)
                
                Image("kookers_logo")
                    .interpolation(.none)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipShape(Circle())
                    .frame(width: 130, height: 130)
                
                
                Text("ONDONDA Prince")
                
                Text("Poulet au curry").font(.footnote).foregroundColor(.gray)
                
                
                BigFiveStartView(stars: 3)
                
                Spacer()
            }
            
                // button
                    VStack {
                        Spacer()
                            HStack {
                             Spacer()
                                RoundLeftButton(button_text: button_text) {
                                    print("this is it")
                                    
                                }

                }.padding(.top, 10)
            }
        }.edgesIgnoringSafeArea(.bottom)
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView()
    }
}
