//
//  ProfilView.swift
//  Kookers
//
//  Created by prince ONDONDA on 30/08/2020.
//  Copyright © 2020 prince ONDONDA. All rights reserved.
//

import SwiftUI

struct ProfilView: View {
    @EnvironmentObject var sessionStored: SessionStore
    
    @State private var birth_date = Date()
    @State var adress = ""
    @State private var birth_place = ""
    
    
    // location search module
    @State var adress_search_is = false
    let locationSearchService = LocationSearch()
    
    
    // for the pictures
    @State var image_picker_is_active = false
    @State var sourcetype: UIImagePickerController.SourceType = UIImagePickerController.SourceType.photoLibrary
    @State var action_sheet_is_presented = false
    @State var button_text: String = "Sauvegarder"
    @State var loading_text: String = "Sauvegarde en cours"
    @State var button_state: RoundedButtonState = .inactive
    
    
    @State var IBAN: String = ""
    
    var body: some View {
            VStack {
                Form{
                    HStack {
                        Spacer()
                        Image("placeholder")
                            .interpolation(.none)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipShape(Circle())
                            .frame(width: 130, height: 130)
                            .overlay(
                                Image(systemName: "plus")
                                .resizable()
                                .foregroundColor(.white)
                                .frame(width: 15, height: 15, alignment: .center)
                                .padding(10.5)
                                .background(Color.blue)
                                .cornerRadius(18)
                                .offset(x: -20, y: -10).onTapGesture {
                                        self.action_sheet_is_presented.toggle()
                                }
                            , alignment: .topTrailing)
                        Spacer()
                    }.padding(.top)
                    
                    
                    HStack {
                        Spacer()
                        VStack (spacing: 10) {
                            Text(sessionStored.session.displayName)
                            FiveStarPanelView(stars: 4, stars_text: "4.4 (168)")
                            .shadow(color: Color.black.opacity(0.1), radius: 20, x: 0, y: 0)
                            .disabled(true)
                        }
                        
                        Spacer()
                    }
                    
                    Spacer().frame(height: 20)
                    
                    
                    
                    // section part.
                    
                    Section(header: Text("PATRONIME"), footer: Text("Nous avons besoin de plus d'informations vous conccernant pour pouvoir activer votre compte vendeur.")) {
                        
                        TextField("Nom", text: self.$sessionStored.session.last_name).disabled(true)
                        TextField("Prénom", text: self.$sessionStored.session.first_name).disabled(true)
                        TextField("Email", text: self.$sessionStored.session.email).disabled(true)
                    }
                    
                    Section(header: Text("NAISSANCE et RÉSIDENCE"), footer: Text("Nous avons besoin de plus d'informations vous conccernant pour pouvoir activer votre compte vendeur.")) {
                        
                        DatePicker(selection: $birth_date, in: ...Date(), displayedComponents: .date) {
                            Text("Date de naissance")
                        }
                        
                        TextField("Lieu de naissance", text: $birth_place)
                        TextField("adresse de residence", text: $adress)
                            
                    }
                    
                    Section(header: Text("PAIEMENTS"), footer: Text("Enregistrer vos méthodes de paiements pour pouvoir facilement sur l'application, enregistrer votre iban pour recevoir vos paiements")) {
                        
                        Button(action: {
                            print("clicked on payments methodes")
                        }, label: {
                            HStack {
                                Text("Methodes de paiements")
                                Spacer()
                            }
                        })
                        
                        TextField("IBAN", text: $IBAN)
                    }
                    
                    Section(header: Text("À PROPOS")) {
                        HStack {
                                Text("Conditions générale d'utilisation")
                                Spacer()
                                }
                        
                        HStack {
                                Text("Politique de confidentialité")
                                Spacer()
                                }
                        
                        HStack {
                                Text("Gestion des cookies")
                                Spacer()
                                }
                        
                        HStack {
                                Text("Version")
                                Spacer()
                                Text("2.2.1")
                                 }
                        }
                    
                    
                    VStack {
                        HStack {
                            Spacer()
                            RoundedButtonView(action: {
                                 self.button_state = .inprogress
                                
                            }, button_state: self.$button_state, inactive_text: self.$button_text, loading_text: self.$loading_text).padding(.top)
                            Spacer()
                        }
                    }
                }
            }.listSeparatorStyleNone()
            .edgesIgnoringSafeArea(.bottom)
        .navigationBarTitle("Profil")
        .background(EmptyView().sheet(isPresented: $adress_search_is) {
            SearchAdressView(LocationCompleter: self.locationSearchService, selectionCity: self.$adress, view_is_open: self.$adress_search_is)
         }).background(EmptyView().sheet(isPresented: $image_picker_is_active) {
            ImagePicker(sourceType: self.sourcetype) { uiimage in
                print("image tooked")
            }
         }).background(EmptyView().actionSheet(isPresented: $action_sheet_is_presented) {
             ActionSheet(title: Text("Prendre depuis"),  buttons: [
                 .default(Text("La bibliothèque")) {
                     self.sourcetype = UIImagePickerController.SourceType.photoLibrary
                     self.image_picker_is_active.toggle()
                 },
                 .default(Text("L'appareil photo")) {
                     self.sourcetype = UIImagePickerController.SourceType.camera
                     self.image_picker_is_active.toggle()
                    
                 },
                 .cancel()
             ])
         })
        
    }
}

struct ProfilView_Previews: PreviewProvider {
    @State static var navBarHidden: Bool = false
    static var previews: some View {
        ProfilView()
    }
}
