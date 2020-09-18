//
//  OnBoardingView.swift
//  Kookers
//
//  Created by prince ONDONDA on 27/08/2020.
//  Copyright © 2020 prince ONDONDA. All rights reserved.
// https://www.freepik.com/stories/13 stories pictures tooked from here
// https://stories.freepik.com/search


import SwiftUI

struct OnBoardingView: View {
    
    
    @State var navigate_to_phone = false

    var body: some View {
            VStack{

                    PageView(self.load_pages())

                
                Spacer()
                
                Divider()
                
                VStack {
                    Spacer().frame(height: 10)
                    HStack {
                        
                        Button(action: {
                            self.navigate_to_phone = true
                        }, label: {
                          Spacer()
                          Text("Se connecter avec un numéro")
                            .foregroundColor(.white)
                            .fontWeight(.regular)
                            Spacer()
                        }).padding(15)
                          .background(Color(UIColor(hexString: "F95F5F")))
                          .cornerRadius(10)
                    }.padding(15)
                    
                    
                    
                    
                    
                    Text("En appuyant sur Creer un compte ou sur connexion, vous acceptez nos conditions d'utilisation. Pour en savoir plus sur l'utilisation de vos donnés, consultez notre politique de confidentialité et note Politique en matiere de cookies.")
                        .fontWeight(.light)
                        .font(.caption).foregroundColor(.gray)
                        .padding(10)
                    
                    
                    NavigationLink(destination: PhoneVerificationView(), isActive: $navigate_to_phone) {
                        EmptyView()
                    }
                }
            }

    }
    
    
    func load_pages() -> [OnboardingPage] {
        var all = [OnboardingPage]()
        for page in Onboarding_Pages {
            all.append(OnboardingPage(page: page))
        }
        return all
    }
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView()
    }
}


extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
