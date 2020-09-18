//
//  SignUpWithEmailView.swift
//  Kookers
//
//  Created by prince ONDONDA on 28/08/2020.
//  Copyright © 2020 prince ONDONDA. All rights reserved.
//

import SwiftUI
import CoreLocation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Firebase
import MapKit
import FirebaseStorage
import FirebaseMessaging
import FirebaseAuth

struct SignUpWithEmailView: View {
    @EnvironmentObject var sessionStore: SessionStore
    @State var last_name:String = ""
    @State var first_name: String = ""
    @State var button_text = "Sauvegarder"
    @State var email = ""
    
    @State var adress = ""
    
    
    
    // location search module
    @State var adress_search_is = false
    let locationSearchService = LocationSearch()
    
    
    // for the pictures
    @State var image_picker_is_active = false
    @State var image_downloaded: UIImage?
    @State var sourcetype: UIImagePickerController.SourceType = UIImagePickerController.SourceType.photoLibrary
    @State var action_sheet_is_presented = false
    
    let placeholder = UIImage(named: "Chef-pana")!
    
    
    let StorageService = KookStorage()
    
    
    var body: some View {
        ZStack {
            
            VStack {
                Form {
                    HStack {
                        Spacer()
                        
                        Image(uiImage: self.image_downloaded ?? self.placeholder)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 130, height: 130)
                            .clipShape(Circle())
                            .overlay(
                                Image(systemName: "camera.fill")
                                .foregroundColor(.white)
                                .frame(width: 15, height: 15, alignment: .center)
                                .padding(10.5)
                                .background(Color.blue)
                                .cornerRadius(18)
                                .offset(x: -20, y: -10).onTapGesture {
                                        self.action_sheet_is_presented.toggle()
                                }
                            , alignment: .topTrailing)
                            .padding(.top)
                        Spacer()
                    }


                        
                    Section(header: Text("INFORMATIONS"), footer: Text("Nous avons besoin de plus d'informations vous concernant pour pouvoir activer votre compte vendeur.")) {
                        TextField("Nom", text: self.$sessionStore.session.last_name)
                        TextField("Prénom", text: self.$sessionStore.session.first_name)
                        TextField("Email", text: self.$sessionStore.session.email)

                    }
                    
                   Section(header: Text("ADRESSE"), footer: Text("Pour pouvoir vous propooser des plats proches de vous , nous avons besoin d'obtenir")) {
                    
                    
                    Button(action: {
                        self.adress_search_is = true
                    }, label: {
                        HStack {
                            Text(self.sessionStore.session.current_adress.complete_adress == "" ? "Choisir une adresse": String(self.sessionStore.session.current_adress.complete_adress))
                            .foregroundColor(.gray)
                            
                            Spacer()
                            Image(systemName: "chevron.down")
                             .foregroundColor(.gray)
                            
                        }
                    })



                    }
                }.onAppear {
                   UITableView.appearance().backgroundColor = .white
                   UITableView.appearance().separatorStyle = .none
                }
            }.padding(.top)
            
            
            
            
            
            VStack {
                Spacer()
                    HStack {
                     Spacer()
                        RoundLeftButton(button_text: button_text) {
                            self.StringAdressToLocation(adress: self.adress) { loc in
                                
                                self.saveUser()
                                
                            }
                        }

                }.padding(.top, 10)
            }
            
        }.navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .edgesIgnoringSafeArea([.bottom])
            
        .background(EmptyView().sheet(isPresented: $adress_search_is) {
            SearchAdressView(LocationCompleter: self.locationSearchService, selectionCity: self.$adress, view_is_open: self.$adress_search_is).environmentObject(self.sessionStore)
         }).background(EmptyView().sheet(isPresented: $image_picker_is_active) {
            ImagePicker(sourceType: self.sourcetype) { uiimage in
                print("image downloaded picked")
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
    
    func saveUser(){
        let user = Auth.auth().currentUser
        let db = self.sessionStore.db.collection("users").document(user!.uid)
        self.sessionStore.session.uid = user!.uid
        self.sessionStore.session.displayName = self.sessionStore.session.first_name + " " + self.sessionStore.session.last_name
        self.sessionStore.session.phonenumber = user!.phoneNumber!
        self.sessionStore.session.fcmToken = Messaging.messaging().fcmToken!
        
        do {
            try db.setData(from: self.sessionStore.session)
        } catch let error {
                   print("Error writing city to Firestore: \(error)")
        }

    }
    
    
    
}

struct SignUpWithEmailView_Previews: PreviewProvider {
    
    static var previews: some View {
        //SignUpWithEmailView(, user: <#User#>)
        Text("hbhb")
    }
}
