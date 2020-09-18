//
//  AdressInPublishView.swift
//  Kookers
//
//  Created by prince ONDONDA on 31/08/2020.
//  Copyright © 2020 prince ONDONDA. All rights reserved.
//

import SwiftUI

struct AdressInPublishView: View {
    var action: () -> Void
    @EnvironmentObject var sessionStore: SessionStore
    var body: some View {
        Button(action: action, label: {
            HStack(spacing: 10) {
                Image(systemName: "house").foregroundColor(Color.gray)
                Spacer()
                Text(String(self.sessionStore.session.current_adress.complete_adress)).foregroundColor(Color.gray).lineLimit(1)
                Spacer()
                Image(systemName: "chevron.down").foregroundColor(Color.gray)
            }.padding()
            
        }).overlay(RoundedRectangle(cornerRadius: 10.0).stroke(lineWidth: 1.0)
            .foregroundColor(Color.gray.opacity(0.5))
        )
    }
}

struct AdressInPublishView_Previews: PreviewProvider {
    static var previews: some View {
        AdressInPublishView(){
            print("yes")
        }
    }
}
