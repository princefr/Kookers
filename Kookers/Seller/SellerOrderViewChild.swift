//
//  SellerOrderViewChild.swift
//  Kookers
//
//  Created by prince ONDONDA on 02/09/2020.
//  Copyright © 2020 prince ONDONDA. All rights reserved.
//

import SwiftUI

struct SellerOrderViewChild: View {
    @EnvironmentObject var session: SessionStore
    @State var order: Order
    @ObservedObject var chatroom: ChatRoom = ChatRoom()
    @State var showReport: Bool = false
    
    
    var chatservice = ChatService()
    
    var body: some View {
        
        VStack {
            
            
            if order.orderstate == .not_accepted {
                
            }else if order.orderstate == .accepted {
                
            }else if order.orderstate == .done {
                
            }else if order.orderstate == .refused {
                
            }else if order.orderstate == .rated {
                
            }
            
            Spacer()
        }.edgesIgnoringSafeArea(.bottom)
        .navigationBarItems(
            leading: OrderStatusView(),
            trailing: HStack(spacing: 25){
           Button(action: {

            let users = [self.session.session.uid, self.order.buyerID]
            self.chatroom.users = [self.session.session.uid : true, self.order.ProductID : true]
            self.chatservice.create_chatrom(users: users, room_to_create: self.chatroom){ room in
                print("")
            }
            
           }) {
               Image(systemName: "message")
           }
           
           Button(action: {
                self.showReport = true
           }) {
               Image(systemName: "exclamationmark.triangle")
           }
        })
    }
}

struct SellerOrderViewChild_Previews: PreviewProvider {
    @State static var order: Order = Order()
    static var previews: some View {
        SellerOrderViewChild(order: order)
    }
}
