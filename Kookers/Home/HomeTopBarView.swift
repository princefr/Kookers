//
//  HomeTopBarView.swift
//  Kookers
//
//  Created by prince ONDONDA on 30/08/2020.
//  Copyright © 2020 prince ONDONDA. All rights reserved.
//

import SwiftUI

struct HomeTopBarView: View {
    var AdressButtonAction: () -> Void
    var ProfilButtonAction: () -> Void
    var ShowPreferencesAction: () -> Void
    
    @EnvironmentObject var sessionStore: SessionStore
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text("KOOKERS")
                        .font(.custom("Saira-Bold", size: 30))
                        .foregroundColor(Color(UIColor(hexString: "F95F5F")))
                    
                    
                    HStack {
                        Button(action: ShowPreferencesAction, label: {
                            Image(systemName: "slider.horizontal.3")
                            .padding(10)
                            .background(Color.gray.opacity(0.5))
                            .clipShape(Circle())
                                .font(.caption)
                            .foregroundColor(Color.black)
                        })
                        
                        Button(action: AdressButtonAction) {
                                HStack(spacing: 15) {
                                    Text(String(self.sessionStore.session.current_adress.complete_adress)).font(Font.custom("Saira-Light", size: 15))
                                    Image(systemName: "chevron.down")
                                        .foregroundColor(.gray)
                                }
                            }
                            .foregroundColor(.black)
                        }

                    }
                

                Spacer(minLength: 0)
                
                
                Button(action: ProfilButtonAction, label: {
                    Image("placeholder")
                      .resizable()
                      .renderingMode(.original)
                      .clipShape(Rectangle())
                      .frame(width: 50, height: 50)
                      .cornerRadius(10)
                    
                })
            }
        }
    }
}

struct HomeTopBarView_Previews: PreviewProvider {
    static var previews: some View {
        HomeTopBarView(AdressButtonAction: {
            print("")
        }, ProfilButtonAction: {
            print("")
        }, ShowPreferencesAction: {
            print("")
        })
    }
}
