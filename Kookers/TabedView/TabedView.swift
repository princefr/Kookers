//
//  TabedView.swift
//  Kookers
//
//  Created by prince ONDONDA on 29/08/2020.
//  Copyright © 2020 prince ONDONDA. All rights reserved.
//

import SwiftUI

struct TabedView: View {
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor.white
        UITabBar.appearance().barTintColor = UIColor.white
    }
    
    @State private var badgeNumber: Int = 3
    private var badgePosition: CGFloat = 4
    private var tabsCount: CGFloat = 4
    
    @State private var selection: Tab = .home
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottomLeading) {
                TabView(selection: self.$selection) {
                    HomeView().tabItem {
                        Image(systemName: "house")
                        Text("Accueil")
                        
                    }.tag(Tab.home)
                    .navigationBarBackButtonHidden(true)
                    .navigationBarHidden(true)
                    
                    BuyerView().tabItem {
                        Image(systemName: "cart")
                        Text("Achats")
                    }.tag(Tab.buys)
                    .navigationBarBackButtonHidden(true)
                    .navigationBarHidden(true)
                    
                    SellerView().tabItem {
                        Image(systemName: "tray.and.arrow.down")
                        Text("Ventes")
                    }.tag(Tab.sells)
                    .navigationBarBackButtonHidden(true)
                    .navigationBarHidden(true)
                        
                    
                    ChatView().tabItem {
                        Image(systemName: "bubble.left")
                        Text("Messages")
                    }.tag(Tab.chat)
                    .navigationBarBackButtonHidden(true)
                    .navigationBarHidden(true)
                    
                    }
                .accentColor(Color(UIColor(hexString: "F95F5F")))
                .introspectTabBarController { tabar in
                    tabar.hidesBottomBarWhenPushed = true
                }
                
                
                
                // Badge View
                ZStack {
                  Circle()
                    .foregroundColor(.red)

                  Text("\(self.badgeNumber)")
                    .foregroundColor(.white)
                    .font(Font.system(size: 12))
                }
                .frame(width: 18, height: 18)
                .offset(x: ( ( 2 * self.badgePosition) - 1 ) * ( geometry.size.width / ( 2 * self.tabsCount ) ), y: -30)
                .opacity(self.badgeNumber == 0 ? 0 : 1)
            }
        }
        
    }
}


enum Tab: Hashable {
    case home, buys, sells, chat
}

struct TabedView_Previews: PreviewProvider {
    static var previews: some View {
        TabedView()
    }
}
