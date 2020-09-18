//
//  HomeView.swift
//  Kookers
//
//  Created by prince ONDONDA on 30/08/2020.
//  Copyright © 2020 prince ONDONDA. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var session: SessionStore
    
    @State var navBarHidden: Bool = true
    @State var navigateToProfil: Bool = false
    @State var show_preferences: Bool = false
    @State var show_search_adress: Bool = false
    @State var adresse: String = ""
    let locationSearchService = LocationSearch()
    
    
    @State var show_publish_sheet: Bool = false
    @State var panelfornotifView = PanelData(title: "sdsds",
                                             detail: "sdsdsdsd", type: .Success)
    @State var showErrorPanel:Bool = false
    
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                HomeTopBarView(AdressButtonAction: {
                    self.show_search_adress.toggle()
                }, ProfilButtonAction: {
                    self.navigateToProfil.toggle()
                }, ShowPreferencesAction: {
                    self.show_preferences.toggle()
                    
                }).padding(.leading)
                    .padding(.trailing)
                
                Divider()

                if self.session.home_publication.count != 0 {
                    ScrollView(.vertical, showsIndicators: true) {
                        Spacer().frame(height: 10)
                        HStack {
                            Text("Proche de vous").font(Font.custom("Saira-Light", size: 20))
                            Spacer()
                        }.padding([.leading, .trailing], 10)
                        Spacer().frame(height: 5)
                        
                        ForEach(self.session.home_publication){ pub in
                            NavigationLink(destination: ProductChild(publication: pub)) {
                                ProductCell(publication: pub).padding(10).cornerRadius(30)
                            }
                        }
                        
                    }.introspectScrollView { scrollView in
                        scrollView.refreshControl = UIRefreshControl()
                    }
                    .padding(.bottom)
                }
                
                Spacer()
            }
            
            
            VStack {
                Spacer()
                    HStack {
                     Spacer()
                        FloatingButton {
                            self.show_publish_sheet = true
                        }
                    }.padding([.bottom, .trailing], 30)
            }
            
            
            NavigationLink(destination: ProfilView(), isActive: $navigateToProfil) {
                EmptyView()
            }
        }
            
        .background(EmptyView().sheet(isPresented: self.$show_preferences, content: {
            FoodPreferenceView(preferencess_is_open: self.$show_preferences).environmentObject(self.session)
        })).background(EmptyView().sheet(isPresented: $show_search_adress, content: {
            SearchAdressView(LocationCompleter: self.locationSearchService, selectionCity: self.$adresse, view_is_open: self.$show_search_adress).environmentObject(self.session)
        })).background(EmptyView().sheet(isPresented: self.$show_publish_sheet, content: {
            PublishView(show_publish_sheet: self.$show_publish_sheet).environmentObject(self.session)
        })).onAppear {
            self.navBarHidden = true
        }.onDisappear {
            self.navBarHidden = false
        }.navigationBarTitle("")
        .navigationBarBackButtonHidden(self.navBarHidden)
        .navigationBarHidden(self.navBarHidden)
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
