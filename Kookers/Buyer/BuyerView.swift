//
//  BuyerView.swift
//  Kookers
//
//  Created by prince ONDONDA on 31/08/2020.
//  Copyright © 2020 prince ONDONDA. All rights reserved.
//

import SwiftUI
import Introspect

struct BuyerView: View {
    @EnvironmentObject var session: SessionStore
    @State var navBarHidden: Bool = true
    @State var refresh_is_done: Bool = false
    @State var is_navigate: Bool = false
    @State var navigationControler: UINavigationController?
    @State var refresh_control: UIRefreshControl?
    var body: some View {
            VStack {
                if self.session.all_buyers_orders.count != 0 {
                        ScrollView(.vertical, showsIndicators: false) {
                            ForEach(self.session.all_buyers_orders, id: \.id){ order in
                                NavigationLink(destination: OrderBuyerViewChild(order: order)) {
                                    OrderBuyerViewCell(order: order)
                                }
                            }
                        }.introspectScrollView { scrollView in
                            scrollView.refreshControl = self.refresh_control
                        }
                    

                 }else{
                    Spacer()
                }
                
            }
        }
}

struct BuyerView_Previews: PreviewProvider {
    static var previews: some View {
        BuyerView()
    }
}




struct OrderBuyerViewCell: View {
    @State var order: Order
    
    static let taskDateFormat: RelativeDateTimeFormatter = {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .short
        return formatter
    }()
    
    var body: some View {
        VStack {
            HStack (spacing: 10) {
                Image("placeholder")
                .renderingMode(.original)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 130)
                
                VStack(alignment: .leading) {
                    Text(order.ProductID).font(.system(size: 15))
                    
                    Spacer()
                    
                    HStack{
                        Text("\(order.createdAt, formatter: Self.taskDateFormat)")
                            .foregroundColor(Color.gray)
                            .font(.caption)
                        
                        Spacer()
                        
                        HStack{
                          Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(Color.green)
                            .font(.caption)
                            
                            Text("en cours")
                            .font(.caption)
                            .foregroundColor(Color.gray)
                        }
                    }
                }.padding([.top, .bottom], 10)
                

                

            }
        }.frame(height: 130)
         .padding([.leading, .trailing], 10)
         .cornerRadius(10)
         .background(Color.white)
         .clipShape(Rectangle())
        
    }
}
