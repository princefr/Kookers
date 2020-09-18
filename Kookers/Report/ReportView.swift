//
//  ReportView.swift
//  Kookers
//
//  Created by prince ONDONDA on 10/09/2020.
//  Copyright © 2020 prince ONDONDA. All rights reserved.
//

import SwiftUI

struct ReportView: View {
    @State var button_text: String = "Signaler le post"
    @State var loading_text = "Signalement en cours"
    @State var button_state: RoundedButtonState = .inactive
    @State var types: [RepostType] = [.FRAUD,  .SPAM, .OTHER]
    @State var type: RepostType = .FRAUD
    @State var text: String = ""
    @State var height: CGFloat = 100
    
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

            
            VStack {
                Picker(selection: self.$type, label: Text("Type de signalement")) {
                    ForEach(self.types, id: \.self) { value in
                        Text(value.localizedName)
                            .tag(value)
                    }
                    
                }.pickerStyle(SegmentedPickerStyle())
                
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation")
                    .font(.caption)
                    .foregroundColor(Color.gray)
            }.padding()
            
            
            TextView(text: self.$text, height: self.$height, placeholder: "Apporter des details .....")
            .mask(RoundedRectangle(cornerRadius: 10.0).foregroundColor(Color.gray))
            .padding([.trailing, .leading])
                
            
            HStack {
                Image(systemName: "info.circle.fill")
                    .font(.caption)
                    .foregroundColor(Color.gray)
                
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation")
                    .font(.caption)
                    .foregroundColor(Color.gray)
                
            }.padding([.trailing, .leading, .bottom])
            
            
            
            

            HStack {
                Spacer()
                RoundedButtonView(action: {
                    self.button_state = .inprogress
                    //self.upload_publication(pub: self.publication)
                }, button_state: self.$button_state, inactive_text: self.$button_text, loading_text: self.$loading_text)
                Spacer()
            }
            
            Spacer()
            
            
        }.edgesIgnoringSafeArea(.bottom)
            .padding(.bottom, 10)
    }
}




enum RepostType: String {
    case NOTINTERRESTED, SPAM, FRAUD, OTHER
    var localizedName: LocalizedStringKey { LocalizedStringKey(rawValue) }
}

struct ReportView_Previews: PreviewProvider {
    static var previews: some View {
        ReportView()
    }
}
