//
//  CountryPickerView.swift
//  Kookers
//
//  Created by prince ONDONDA on 28/08/2020.
//  Copyright © 2020 prince ONDONDA. All rights reserved.
//

import SwiftUI

struct CountryPickerView: View {
    @State var Countries: [Country] = Bundle.main.decode("countries.json")
    @State var country_picker_button_text = "Sauvegarder"
    @State var searchText = ""
    @Binding var Chosed_country: Country
    @Binding var is_coountry_picker_active: Bool
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Spacer()
                    Rectangle().frame(width: 80, height: 5)
                        .cornerRadius(10)
                        .padding(.top, 10)
                        .foregroundColor(Color.gray)
                    Spacer()
                }
                
                Spacer().frame(height: 40)
                
                VStack {
                    HStack(spacing: 15){
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(Color.gray)
                        
                        TextField("Rechercher un pays", text: $searchText)
                            .foregroundColor(Color.gray)
                        
                        
                        
                        if !self.searchText.isEmpty {
                            Button(action: {
                                self.searchText = ""
                            }) {
                                Image(systemName: "xmark")
                                    .foregroundColor(Color.white)
                                    .padding(8)
                                    .clipShape(Circle())
                                    .background(Color(UIColor(hexString: "F95F5F")))
                                    .cornerRadius(3)
                                    .animation(.spring())
                            }.clipShape(Circle())
                        }

                    }
                    .padding(.vertical,12)
                    .padding(.horizontal)
                    .background(Color.white)
                    .clipShape(Rectangle())
                    .cornerRadius(5)
                }
                
                List{
                    
                    ForEach(Countries.filter{$0.id.hasPrefix(searchText) || searchText == ""}) {country in
                        RadioSwitch(country: country) {
                                country.toogle()
                                self.Chosed_country = country
                                self.is_coountry_picker_active = false
                                self.Countries.map {
                                    if $0.id != country.id {
                                        $0.set_to_false()
                                    }
                            }
                        }.animation(.spring())
                    }
                }.onAppear{
                    UITableView.appearance().backgroundColor = .white
                    UITableView.appearance().separatorStyle = .none
                }
            }

            

        }.edgesIgnoringSafeArea([.bottom, .trailing])
        
    }
}

struct CountryPickerView_Previews: PreviewProvider {
    @State static var chosed_country: Country = Country(id: "France", dialcode: "+33", code: "FR")
    @State static var is_coountry_picker_active: Bool = false
    static var previews: some View {
        CountryPickerView(Chosed_country: $chosed_country, is_coountry_picker_active: $is_coountry_picker_active)
    }
}

class Country: ObservableObject,  Codable,  Identifiable {
    // "name":"Afghanistan","dial_code":"+93","code":"AF"
    var id: String
    var dialcode : String
    var code: String
    @Published var is_selected = false
    
    init(id: String, dialcode: String, code: String) {
        self.id = id
        self.dialcode = dialcode
        self.code = code
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "name"
        case dialcode = "dial_code"
        case code
    }
    
    func toogle(){
        self.is_selected.toggle()
    }
    
    func set_to_false(){
        self.is_selected = false
    }
    
}


extension Bundle {
    func decode(_ file: String) -> [Country]{
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }
        
        let decoder = JSONDecoder()
        guard let loaded = try? decoder.decode([Country].self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }

        return loaded
    }
}
