//
//  SellerView.swift
//  Kookers
//
//  Created by prince ONDONDA on 31/08/2020.
//  Copyright © 2020 prince ONDONDA. All rights reserved.
//

import SwiftUI

struct SellerView: View {
    @EnvironmentObject var session: SessionStore
    var menu = ["Plats en vente", "Commandes"]
    @State var  selectedMenu = 0
    @State var navBarHidden: Bool = true
    
    var body: some View {
        
        VStack {
            
            HStack {
                NavigationLink(destination: WalletView()) {
                    Text("15 €")
                }
            }
            HStack{
                Picker(selection: $selectedMenu, label: Text("")) {
                    ForEach(0 ..< menu.count) {
                        Text(self.menu[$0])
                    }
                }.pickerStyle(SegmentedPickerStyle())
            }.padding([.trailing, .leading, .bottom])
            
            
            if selectedMenu == 0 {
                if self.session.all_publications.count != 0 {
                    ScrollView(.vertical, showsIndicators: false) {
                        ForEach(self.session.all_publications){ pub in
                            NavigationLink(destination: SellerPublicationChildView(publication: pub)) {
                                SellerViewRow(publication: pub)
                            }
                        }
                    }.introspectScrollView { scrollView in
                        scrollView.refreshControl = UIRefreshControl()
                    }
                }
            }else{
                if session.all_seller_orders.count != 0 {
                    ScrollView(.vertical, showsIndicators: false) {
                        ForEach(self.session.all_seller_orders){ order in
                            NavigationLink(destination: SellerOrderViewChild(order: order)) {
                                SellerOrderCell(order: order)
                            }
                        }
                    }.introspectScrollView { scrollView in
                        scrollView.refreshControl = UIRefreshControl()
                    }
                }
                
                
            }
        }
        
    }
}

struct SellerView_Previews: PreviewProvider {
    static var previews: some View {
        SellerView()
    }
}


struct SellerViewRow: View {
    @State var publication: Publication
    var body: some View {
        VStack(alignment: .leading) {
            Image("placeholder")
            .renderingMode(.original)
            .resizable()
            .scaledToFit()
                .frame(height: 150)
            
            Spacer()
            
            
            VStack(alignment: .leading, spacing: 6) {
                Text(publication.title)
                    .fontWeight(Font.Weight.heavy)
                
                Text(publication.description)
                    .font(Font.custom("HelveticaNeue-light", size: 16))
                    .foregroundColor(Color.gray)
            }
            
        }
    }
}



struct SellerOrderCell: View {
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
                
                VStack (alignment: .leading, spacing: 5) {
                    Text(order.ProductID).font(Font.custom("Saira-Light", size: 16))

                    
                    HStack {
                        Image(systemName: "person.fill")
                          .foregroundColor(Color.gray)
                          .font(.caption)
                        
                        Text("ONDONDA Prince").foregroundColor(Color.gray)
                        .font(Font.custom("Saira-Light", size: 12))
                    }
                    
                    
                    HStack {
                        Image(systemName: "eurosign.circle.fill")
                          .foregroundColor(Color.gray)
                          .font(.caption)
                        
                        Text("\(order.total_price)").foregroundColor(Color.gray)
                        .font(Font.custom("Saira-Light", size: 16))
                        
                    }
                    
                    
                    

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
         .cornerRadius(10)
         .padding([.leading, .trailing], 10)
         .background(Color.white)
         .clipShape(Rectangle())
        
    }
}
