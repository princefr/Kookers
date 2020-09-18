//
//  SellerPublicationChildView.swift
//  Kookers
//
//  Created by prince ONDONDA on 02/09/2020.
//  Copyright © 2020 prince ONDONDA. All rights reserved.
//

import SwiftUI

struct SellerPublicationChildView: View {
    @State var publication: Publication
    @State var button_text: String = "Fermer la vente"
    @State var button_state: RoundedButtonState = .inactive
    @State var loading_text: String = "Fermeture en cours"
    var body: some View {
        VStack {
           
            // button shit
            
            Spacer()
            VStack {
                HStack {
                    Spacer()
                    RoundedButtonView(action: {
                         self.button_state = .inprogress
                        
                    }, button_state: self.$button_state, inactive_text: self.$button_text, loading_text: self.$loading_text).padding(.top)
                    Spacer()
                }
            }.padding(.bottom)
        }.edgesIgnoringSafeArea(.bottom)

    }
}

struct SellerPublicationChildView_Previews: PreviewProvider {
    @State static var publication: Publication = Publication()
    static var previews: some View {
        SellerPublicationChildView(publication: publication)
    }
}
