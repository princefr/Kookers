//
//  OrderBuyerViewChild.swift
//  Kookers
//
//  Created by prince ONDONDA on 01/09/2020.
//  Copyright © 2020 prince ONDONDA. All rights reserved.
//

import SwiftUI

struct OrderBuyerViewChild: View {
    @EnvironmentObject var session: SessionStore
    var chatservice = ChatService()
    @State var order: Order
    @ObservedObject var chatroom: ChatRoom = ChatRoom()
    @State var button_text: String = "Annuler"
    @State var showRatePanel: Bool = false
    @State var showRateReportPanel: Bool = false
    @State var  button_state : RoundedButtonState = .inactive
    @State var loading_text: String = "Annulation en cours"
    
    var body: some View {
        
        VStack {

            if order.orderstate == .not_accepted {
                Text("not accepted")
            }else if order.orderstate == .accepted {
                Text("accepted")
            }else if order.orderstate == .done {
                Text("done")
            }else if order.orderstate == .refused {
                Text("refused")
            }else if order.orderstate == .rated {
                Text("rated")
            }
            
            
            Spacer()
            
            VStack {
                HStack {
                    Spacer()
                    RoundedButtonView(action: {
                         self.showRatePanel = true
                         self.button_state = .inprogress
                        
                    }, button_state: self.$button_state, inactive_text: self.$button_text, loading_text: self.$loading_text).padding(.top)
                    Spacer()
                }
            }.padding(.bottom)
            
        }
        .navigationBarItems(
            leading: OrderStatusView(),
            trailing: HStack(spacing: 25){
           Button(action: {
            let users = [self.session.session.uid, self.order.sellerID]
            self.chatroom.users = [self.session.session.uid : true, self.order.ProductID : true]
            self.chatservice.create_chatrom(users: users, room_to_create: self.chatroom){ room in
                print("i've found a room")
            }
           }) {
               Image(systemName: "message")
           }
           
           Button(action: {
              print("report button")
            self.showRateReportPanel = true
           }) {
               Image(systemName: "exclamationmark.triangle")
           }
        }).edgesIgnoringSafeArea(.bottom)
          .background(EmptyView().sheet(isPresented: self.$showRatePanel, content: {
                RatingView()
          }))
            .background(EmptyView().sheet(isPresented: self.$showRateReportPanel, content: {
                ReportView()
            }))
    }
}

struct OrderBuyerViewChild_Previews: PreviewProvider {
    static var previews: some View {
        OrderBuyerViewChild(order: Order(uid: "sdsdsd", productid: "sdsdsd", transactionid: "sdkjsd", quantity: 2.0, retrieveDate: Date(), total_price: 10.0, buyerID: "sdsdsdsd", orderstate: .accepted, sellerID: "sds;d,;sd,kshjdjhsd"))
    }
}
