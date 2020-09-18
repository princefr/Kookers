//
//  SearchAdressView.swift
//  Kookers
//
//  Created by prince ONDONDA on 29/08/2020.
//  Copyright © 2020 prince ONDONDA. All rights reserved.
//

import SwiftUI
import MapKit
import CoreLocation

struct SearchAdressView: View {
    
    @ObservedObject var LocationCompleter: LocationSearch
    @Binding var selectionCity: String
    @Binding var view_is_open: Bool
    @EnvironmentObject var storedSession: SessionStore
    
    
    var body: some View {
        VStack (alignment: .leading) {
            HStack {
                Spacer()
                Rectangle().frame(width: 80, height: 5)
                    .cornerRadius(10)
                    .padding(.top, 10)
                    .foregroundColor(Color.gray)
                Spacer()
            }
            
            
            Spacer().frame(height: 40)
            
            SearchBar(text: $LocationCompleter.searchQuery, placeholder: "Saisir une adresse")
            
            Divider()
            
            if !LocationCompleter.searchQuery.isEmpty {
                List(LocationCompleter.completions){ completion in
                    AdressRow(adress: completion) {
                        let complete_adress = completion.title + " , " + completion.subtitle
                        self.StringAdressToLocation(adress: complete_adress, location: { loc in
                            
                            let new_adress = AdressModel(title: completion.title, subtitle: completion.subtitle, lat: loc.coordinate.latitude, long: loc.coordinate.longitude, ischoosed: true)
                            
                            self.storedSession.session.current_adress = new_adress
                            self.storedSession.session.addNewAdress(adress: new_adress)
                            
                            if self.storedSession.is_user_exist {
                                self.storedSession.update()
                                self.storedSession.get_publication_near_user()
                            }
                            self.selectionCity = complete_adress
                            self.view_is_open.toggle()
                        })
                    }
                }
            }else{
                HStack{
                    Image(systemName: "house.fill").foregroundColor(Color.gray)
                    Text("Vos Adresses").font(Font.custom("Saira-Light", size: 18))
                }.padding()
                List(self.storedSession.session.all_searched_adresses) { adresse in
                    AdressSwitch(adress: adresse) {
                        self.storedSession.session.adress_switch_update(adress: adresse)
                        if self.storedSession.is_user_exist {
                            self.storedSession.update()
                            self.storedSession.get_publication_near_user()
                        }
                        self.view_is_open.toggle()
                    }
                
                }
            }
            
            Spacer()
            
        }.onAppear{
            UITableView.appearance().backgroundColor = .white
            UITableView.appearance().separatorStyle = .none
        }
    }
    
    
    func StringAdressToLocation(adress: String, location: @escaping (CLLocation) ->Void){
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(adress) { placemarks, error in
              guard let placemarks = placemarks, let location_of = placemarks.first?.location
                  else{
                     return
            }
            location(location_of)
        }
    }
}

struct SearchAdressView_Previews: PreviewProvider {
    static var previews: some View {
        //SearchAdressView()
        Text("this")
    }
}
