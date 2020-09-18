//
//  ContentView.swift
//  Kookers
//
//  Created by prince ONDONDA on 27/08/2020.
//  Copyright © 2020 prince ONDONDA. All rights reserved.
//

import SwiftUI


struct ContentView: View {
    @State var showSplash = true
    @EnvironmentObject var session: SessionStore
    @State var chosed_country: Country = Country(id: "France", dialcode: "+33", code: "FR")
    
    func getUser () {
        session.listen()
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                if (session.session.uid != "") {
                    TabedView()
                } else {
                    OnBoardingView().environmentObject(self.session)
                }
                
                
                
                // splash screen
                SplashScreen().opacity(showSplash ? 1 : 0)
            }.onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                  withAnimation() {
                    self.showSplash = false
                  }
                }
            }.onAppear(perform: getUser)
            
        }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
