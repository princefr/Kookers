//
//  PublishView.swift
//  Kookers
//
//  Created by prince ONDONDA on 31/08/2020.
//  Copyright © 2020 prince ONDONDA. All rights reserved.
//

import SwiftUI
import CoreLocation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct PublishView: View {
    @Binding var show_publish_sheet: Bool
    @State var button_text = "Publier le plat"
    @State var loading_text = "Publication en cours"
    @State var button_state: RoundedButtonState = .inactive
    
    @ObservedObject var publication: Publication = Publication()
    @State var selling_type: [SellingType] = [.desserts, .plates]
    @EnvironmentObject var storedSession: SessionStore
    
    // location search module
    @State var adress_search_is = false
    let locationSearchService = LocationSearch()
    
    @State var image_1: UIImage?
    @State var image_2: UIImage?
    @State var image_3: UIImage?
    @State var image_4: UIImage?
    @State var  placeholder = UIImage(named: "placeholder.png")!
    @State var image_at_it = 0
    @State var adress = ""
    @State var TextViewHeight: CGFloat = 50
    
    
    // action picker
    @State var image_picker_is_active = false
    @State var sourcetype: UIImagePickerController.SourceType = UIImagePickerController.SourceType.photoLibrary
    @State var action_sheet_is_presented = false
    
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
                
                Spacer().frame(height: 30)
                
                Form {
                    
                    Section(header: Text("PHOTOS")) {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack (spacing: 10) {
                                PublishButtonImage(placeholder: $placeholder, image_1: $image_1) {
                                    self.image_at_it = 0
                                    self.action_sheet_is_presented = true
                                }
                                
                                PublishButtonImage(placeholder: $placeholder, image_1: $image_2) {
                                    self.image_at_it = 1
                                    self.action_sheet_is_presented = true
                                }
                                
                                PublishButtonImage(placeholder: $placeholder, image_1: $image_3) {
                                    self.image_at_it = 2
                                    self.action_sheet_is_presented = true
                                }
                                
                                PublishButtonImage(placeholder: $placeholder, image_1: $image_4) {
                                    self.image_at_it = 3
                                    self.action_sheet_is_presented = true
                                }
                                
                            }
                        }
                    }
                    
                    
                    Section(header: Text("NOM ET DESCRIPTION DU PLAT"), footer: Text("Veuillez nommé et décrire le plat dans le plus grand des détails. cela aidera le client à se faire une idée.")) {
                        
                        TextField("Nom du plat", text: self.$publication.title).padding(.leading, 4)
                        
                        
                        TextView(text: self.$publication.description, height: self.$TextViewHeight, placeholder: "Description du plat")
                        
                        
                        
                    }
                    
                    
                    Section(header: Text("TYPE DE LA VENTE"), footer: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua")) {
                        
                        Picker(selection: self.$publication.type, label: Text("Type de plat")) {
                            ForEach(SellingType.allCases, id: \.self) { value in
                                Text(value.localizedName)
                                    .tag(value)
                            }
                            
                        }.pickerStyle(SegmentedPickerStyle())
                        
                    }
                    
                    Section(header: Text("PRÉFÉRENCES ALIMENTAIRES"), footer: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua")) {
                        
                        // Végétarien, Vegan, Sans gluten, Halal, adapté aux allergies.
                        MultiSelectPreference(all_preferences: self.publication.food_preferences)
                        
                    }
                    
                    Section(header: Text("TARIFICATION"), footer: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua")) {
                        
                        PriceTextField(text_par_part: self.$publication.price_per_pie, text_par_complet: self.$publication.price_all, selected_plate_type: self.$publication.type).animation(.spring())

                    }
                    
                    Section(header: Text("VOS INFORMATIONS"), footer: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua")) {
                        
                        AdressInPublishView {
                            self.adress_search_is.toggle()
                        }

                    }
                    
                    VStack {
                        HStack {
                            Spacer()
                            RoundedButtonView(action: {
                                self.button_state = .inprogress
                                //self.upload_publication(pub: self.publication)
                            }, button_state: self.$button_state, inactive_text: self.$button_text, loading_text: self.$loading_text)
                            Spacer()
                        }
                    }
                    

                }
                
                
                Spacer()
                

            }.background(EmptyView().sheet(isPresented: $adress_search_is) {
            SearchAdressView(LocationCompleter: self.locationSearchService, selectionCity: self.$adress, view_is_open: self.$adress_search_is).environmentObject(self.storedSession)
        }).background(EmptyView().sheet(isPresented: $image_picker_is_active) {
           ImagePicker(sourceType: self.sourcetype) { uiimage in
            if self.image_at_it == 0 {
                self.image_1 = uiimage
            }else if self.image_at_it == 1 {
                self.image_2 = uiimage
            }else if self.image_at_it == 2 {
                self.image_3 = uiimage
            }else if self.image_at_it == 3 {
                self.image_4 = uiimage
            }
            
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
        }).edgesIgnoringSafeArea(.bottom)
         .onAppear {
                UITableView.appearance().backgroundColor = .white
                UITableView.appearance().separatorStyle = .none
        }
    }
    
    
    func upload_publication(pub: Publication) {
        if self.image_1 != nil && self.image_2 != nil && self.image_3 != nil && self.image_4 != nil {
            let pubdb = self.storedSession.publicationRef
            let id = pubdb.document().documentID
            self.storedSession.sendImages(publicationRef: id, images: [self.image_1!.jpegData(compressionQuality: 80)!, self.image_2!.jpegData(compressionQuality: 80)!, self.image_3!.jpegData(compressionQuality: 80)!, self.image_4!.jpegData(compressionQuality: 80)!]) { (urls) in
                if urls != nil && urls!.count > 0 {
                    self.publication.SellerID = self.storedSession.session.uid
                    self.publication.uid = id
                    self.publication.images_urls = urls!
                    let location = CLLocation(latitude: self.storedSession.session.current_adress.lat, longitude: self.storedSession.session.current_adress.long)
                    self.publication.geo_hash = location.geohash(length: 10)

                    do {
                        try pubdb.document(id).setData(from: pub)
                        self.show_publish_sheet.toggle()
                    } catch {
                        print("Error Signing Out")
                    }
                }else{
                    print("i've an error here")
                }
            }
        }else{
            print("fill all")
        }

    }
}

struct PublishView_Previews: PreviewProvider {
    static var previews: some View {
        PublishView(show_publish_sheet: .constant(true))
    }
}
