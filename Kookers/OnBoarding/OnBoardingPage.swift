//
//  OnBoardingPage.swift
//  Kookers
//
//  Created by prince ONDONDA on 27/08/2020.
//  Copyright © 2020 prince ONDONDA. All rights reserved.
//

import SwiftUI


struct OnboardingPage: View {
    var page: Page_Model
    
    var body: some View {
        VStack {
            Image(page.image)
                .resizable()
                .scaledToFit()
                
            
            Text(page.title)
                .font(.subheadline).bold()
                .padding(.bottom)
            
            Text(page.descrip)
                .multilineTextAlignment(.center)
                .padding()
                .foregroundColor(.gray)
            

        }.padding(.bottom)
        .edgesIgnoringSafeArea(.all)
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .navigationBarTitle("")
    }
}

struct OnboardingPage_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingPage(page: Page_Model(id: 0, image: "turtlerock", title: "Discover places near you", descrip: "We make it simple to find the food you crave. Enter your  home addresse and let us do the rest."))
    }
}

