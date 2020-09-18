//
//  FoodPreferenceView.swift
//  Kookers
//
//  Created by prince ONDONDA on 30/08/2020.
//  Copyright © 2020 prince ONDONDA. All rights reserved.
//

import SwiftUI
import Combine
import Firebase
import FirebaseFirestoreSwift

struct FoodPreferenceView: View {
    @State var button_text = "Sauvegarder"
    @State private var distance: Double = 0
    @EnvironmentObject var storedSession: SessionStore
    @Binding var preferencess_is_open: Bool
    @State var button_state: RoundedButtonState = .inactive
    @State var loading_text: String = "Sauvegarde en cours"

    var body: some View {

            VStack {
                HStack {
                    Spacer()
                    Rectangle().frame(width: 80, height: 5)
                        .cornerRadius(10)
                        .padding(.top, 10)
                        .foregroundColor(Color.gray)
                    Spacer()
                }
                
                
                Form {
                    
                    Section(header: Text("FOURCHETTE DE PRIX"), footer: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua")) {
                        
                        MultiSelectPrice(all_range: self.storedSession.session.settings.food_price_range)
                        
                    }
                    
                    Section(header: Text("PRÉFÉRENCES ALIMENTAIRES"), footer: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua")) {
                        
                        MultiSelectPreference(all_preferences: self.storedSession.session.settings.food_preferences)
                    }
                    
                    
                    Section(header: Text("Distance"), footer: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua")) {
                        
                        HStack {
                               Slider(value: self.$storedSession.session.settings.distance_from_seller, in: 0...40, step: 1).accentColor(Color(UIColor(hexString: "F95F5F")))
                            Spacer().frame(width: 20)
                            Text("\(Int(self.storedSession.session.settings.distance_from_seller))" + " KM").bold().frame(alignment: .trailing).font(Font.custom("Saira-Light", size: 16))
                        }
                    }
                    
                    
                    
                    VStack {
                        HStack {
                            Spacer()
                            RoundedButtonView(action: {
                                 self.button_state = .inprogress
                                 self.storedSession.update()
                                 self.preferencess_is_open.toggle()
                                 self.storedSession.get_publication_near_user()
                                 self.button_state = .inactive
                            }, button_state: self.$button_state, inactive_text: self.$button_text, loading_text: self.$loading_text).padding(.top)
                            Spacer()
                        }
                    }
                    
                    
                    
                    
                }.padding(.top)
                 .onAppear{
                    UITableView.appearance().backgroundColor = .white
                    UITableView.appearance().separatorStyle = .none
                }
                
            }

    }
}

struct FoodPreferenceView_Previews: PreviewProvider {
    static var previews: some View {
        //FoodPreferenceView()
        EmptyView()
    }
}


struct MultiSelectPrice: View {
    @State var all_range: [FoodPriceRange]
    
    var body: some View {
        ScrollView (.horizontal, showsIndicators: false){
            HStack {
                ForEach(self.all_range) { preference in
                    MultiSelectionRow(action: {
                        preference.toogle()
                    }, food_price_range: preference)
                }

            }
        }

    }
}


struct MultiSelectionRow: View {
    var action: ()->Void
    @ObservedObject var food_price_range: FoodPriceRange
    
    var body: some View {
        Button(action: self.action) {
            Text(self.food_price_range.title)
                .foregroundColor(self.food_price_range.is_selected == true ? Color.white : Color.gray)
                .font(Font.custom("Saira-Light", size: 16))
            .padding(10)
        }
        .background(self.food_price_range.is_selected == true ? Color(UIColor(hexString: "F95F5F")): Color.gray.opacity(0.2))
        .clipShape(Circle())
        .animation(.spring())
        .padding(10)
    }
}



