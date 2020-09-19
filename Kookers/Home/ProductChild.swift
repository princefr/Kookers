//
//  ProductChild.swift
//  Kookers
//
//  Created by prince ONDONDA on 01/09/2020.
//  Copyright © 2020 prince ONDONDA. All rights reserved.
//

import SwiftUI
import ExyteGrid
import BottomSheet

struct ProductChild: View {
    @EnvironmentObject var session: SessionStore
    @State var publication: Publication
    @State var button_text: String = "Acheter"
    @State var loading_text: String = "Achat en cours"
    @State var button_state: RoundedButtonState = .inactive
    @ObservedObject var buymodel: Order = Order()
    @State var percent: CGFloat = 15.5
    @State var show_progress: Bool = false
    @State var quantity = 1
    
    @State var contentMode: GridContentMode = .fill
    @State var show_bottom_sheet = false
    
    @State var showReport: Bool = false
    @State var date: Date = Date()
    
    @State var offset : CGFloat = UIScreen.main.bounds.height
    @State var page1: PagePhotos?
    @State var page2: PagePhotos?
    @State var page3: PagePhotos?
    @State var page4: PagePhotos?
    
    
    
    var body: some View {
        ZStack {
            ScrollView(.vertical, showsIndicators: false) {
                HStack {
                    PageView([PagePhotos(url: self.publication.images_urls[0]), PagePhotos(url: self.publication.images_urls[1]),PagePhotos(url: self.publication.images_urls[2]), PagePhotos(url: self.publication.images_urls[3])])
                }.frame(height: 250)
                

                VStack (alignment: .leading, spacing: 0) {
                        HStack {
                            Text(publication.title).font(Font.custom("Saira-Light", size: 21))
                            
                            Spacer()
                            VStack {
                                Text("\(publication.price_per_pie) €").font(Font.custom("Saira-Light", size: 21)).lineLimit(1)
                                  
                                if !publication.price_all.isEmpty {
                                    Text("\(publication.price_all) €").font(Font.custom("Saira-Light", size: 21)).lineLimit(1)
                                }
                            }
                        }.padding([.leading, .trailing], 10)
                        
                        FiveStarPanelView(stars: 4, stars_text: "4.4 (168)").disabled(true).font(.caption)
                    }.padding(5)
                    
                    

                    Grid(self.publication.food_preferences, id: \.id, tracks: 4) {
                               if $0.is_selected {
                                    PrefInside(preference: $0)
                            }
                    }

                    Text(self.publication.description).fixedSize(horizontal: false, vertical: true)
                        .padding(10)
                    
                    
                    Divider()
                    

                    VStack(alignment: .leading) {
                        Text("PASSER COMMANDE").font(Font.custom("Saira-Light", size: 18))

                        Stepper(String(Int(self.$buymodel.quantity.wrappedValue)), value: self.$buymodel.quantity, in: 1...130).padding(.trailing)

                        MultiSelectChooseDate(action: {
                            self.show_bottom_sheet = true
                        })
                        
                    }.padding([.leading, .trailing])
                    
                    Text("Enregistrer vos méthodes de paiements pour pouvoir faciliter vos achats sur l'application Tinda.")
                    .font(.caption)
                    .padding([.leading, .trailing], 5)

                    HStack {
                        Spacer()
                        RoundedButtonView(action: {
                             self.button_state = .inprogress
                            
                        }, button_state: self.$button_state, inactive_text: self.$button_text, loading_text: self.$loading_text).padding(.top)
                        Spacer()
                    }.padding(.top)

                

            }.bottomSheet(isPresented: self.$show_bottom_sheet, height: 400, content: {
                CustomActionSheet(date: self.$date, action: {
                    print("this was choosed")
                    self.show_bottom_sheet = false
                })
            })
            
        }.background(EmptyView().sheet(isPresented: self.$showReport, content: {
                ReportView()
         })).navigationBarItems(trailing: HStack(spacing: 25){
            Button(action: {
                self.showReport = true
            }) {
                Image(systemName: "exclamationmark.triangle")
            }
            
            Button(action: {
                print("like")
            }) {
                Image(systemName: "suit.heart")
            }
         }).onAppear(perform: {
            self.loadPages()
         }).navigationBarTitle(self.publication.title)
    }
    
    
    func loadPages() {
        let picture1 = PagePhotos(url: self.publication.images_urls[0])
        let picture2 = PagePhotos(url: self.publication.images_urls[1])
        let picture3 = PagePhotos(url: self.publication.images_urls[2])
        let picture4 = PagePhotos(url: self.publication.images_urls[3])
        self.page1 = picture1
        self.page2 = picture2
        self.page3 = picture3
        self.page4 = picture4
    }
}




var all_food_preferences_ = [
    FoodPreferences(id: 0 , title: "Végétarien", is_selected: true),
    FoodPreferences(id: 1 , title: "Vegan", is_selected: true),
    FoodPreferences(id: 2 , title: "Sans gluten", is_selected: true),
    FoodPreferences(id: 3 , title: "Hallal", is_selected: true),
    FoodPreferences(id: 4 , title: "Adapté aux allergies alimentaires", is_selected: true)
]

struct ProductChild_Previews: PreviewProvider {
    static var previews: some View {
        ProductChild(publication: Publication(uid: "sdsdsd", title: "Poulet au curry", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam", type: .desserts, food_preferences: all_food_preferences_, price_all: "10", price_per_pie: "25", sdresse: "303 quai aux fleurs", sellerID: "ssd", is_open: true, geo_hash: "sdsd", images_urls: []))
    }
}






struct PrefInside: View {
    @State var preference : FoodPreferences
    var body: some View {
        Text(preference.title)
            .font(Font.custom("Saira-Light", size: 12))
            .padding(5)
            .foregroundColor(Color.white)
            .background(Color(UIColor(hexString: "F95F5F")))
            .cornerRadius(3)
    }
}

class ChooseDateSetting: ObservableObject, Identifiable, Codable {
    @Published var id : Int
    @Published var title : String
    @Published var is_selected : Bool
    @Published var image_string: String
    
    
    init(id: Int, title: String, is_selected: Bool, image_string: String) {
        self.id = id
        self.title = title
        self.is_selected = is_selected
        self.image_string = image_string
    }
    
    init(){
        self.id = 0
        self.title = ""
        self.is_selected = false
        self.image_string = ""
    }
    
    func toogle(){
        self.is_selected.toggle()
    }
    
    
    func set_to_false(){
        self.is_selected = false
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case is_selected
        case image_string
    }
    
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        is_selected = try container.decode(Bool.self, forKey: .is_selected)
        image_string = try container.decode(String.self, forKey: .image_string)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(is_selected, forKey: .is_selected)
        try container.encode(image_string, forKey: .image_string)
    }
}


var allDateSettings = [ChooseDateSetting(id: 0, title: "Plus tot possible", is_selected: true, image_string: "clock"), ChooseDateSetting(id: 1, title: "Planifier", is_selected: false, image_string: "calendar")]



struct MultiSelectChooseDate: View {
    @State var all_dates_to_chose: [ChooseDateSetting] = allDateSettings
    var action: () -> Void
    var body: some View {
        VStack {
            ForEach(all_dates_to_chose, id: \.id) { dates in
                ChooseDateCell(chooseDateSetting: dates) {
                    dates.toogle()
                    self.all_dates_to_chose.map {
                        if $0.id != dates.id {
                            $0.set_to_false()
                        }
                        
                        
                        if dates.id == 1 && dates.is_selected == true {
                            self.action()
                        }
                    }
                }
            }
        }.padding(.top, 20)
    }
}




struct ChooseDateCell: View {
    @ObservedObject var chooseDateSetting: ChooseDateSetting
    var action: () -> Void
    var body: some View {
        Button(action: action, label: {
            VStack {
                HStack {
                    Image(systemName: chooseDateSetting.image_string).foregroundColor(Color.gray)
                    Text(chooseDateSetting.title).foregroundColor(Color.gray)
                    
                    Spacer()
                    
                    if chooseDateSetting.is_selected {
                        Image(systemName: "checkmark.circle.fill").foregroundColor(Color.green)
                    }
                }.padding(5)
                
                Divider().padding([.leading], 30)
            }
        }).animation(.spring())
    }
}
