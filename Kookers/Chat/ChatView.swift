//
//  ChatView.swift
//  Kookers
//
//  Created by prince ONDONDA on 31/08/2020.
//  Copyright © 2020 prince ONDONDA. All rights reserved.
//

import SwiftUI

struct ChatView: View,  RefreshDelegate {
    @EnvironmentObject var session: SessionStore
    @State var navBarHidden: Bool = true
    @State var searchText: String = ""
    @State var refresh_control: UIRefreshControl?
    var helper = RefreshHelper()
    
    func isRefreshing() {
        self.session.loadAllChatRoom { _ in
            self.refresh_control?.endRefreshing()
            
        }
        
    }
    
    var body: some View {
        VStack {
            SearchBar(text: $searchText, placeholder: "Rechercher")
            
            if self.session.chatrooms.count != 0 {
                ScrollView(.vertical, showsIndicators: false) {
                    ForEach(self.session.chatrooms) { room in
                        NavigationLink(destination: ChatViewChild(room: room).environmentObject(self.session)) {
                            ChatViewRow(room: room)
                        }
                    }
                }.introspectScrollView { scrollView in
                    scrollView.refreshControl = self.refresh_control
                }
            }
        }.onAppear(perform: {
            self.navBarHidden = true
            self.refresh_control = UIRefreshControl()
            self.refresh_control?.addTarget(self.helper, action: #selector(self.helper.closeAction), for: UIControl.Event.valueChanged)
            self.helper.delegate = self
        })
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}


protocol RefreshDelegate {
    func isRefreshing()
}


class RefreshHelper: ObservableObject {
    @Published var delegate: RefreshDelegate?

    @objc public func closeAction() {
        self.delegate!.isRefreshing()
  }
}



struct ChatViewRow: View {
    @State var room: ChatRoom
    static let taskDateFormat: RelativeDateTimeFormatter = {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .short
        return formatter
    }()
    
    var body: some View {
        HStack(spacing: 15) {
            Image("placeholder")
                .renderingMode(.original)
                .resizable()
                .frame(width: 42, height: 42)
                .clipShape(Circle())
            
            VStack(alignment: .leading,spacing: 3){
                Text("ONDONDA Prince").foregroundColor(Color.black)
                
                Text("De toute facon quoi que tu puissses faire je serais toujours la ")
                    .foregroundColor(.gray)
                    .lineLimit(1)
                    .font(.system(size: 14))
            }
            
            Spacer()
            
            Text("\(room.updatedAt, formatter: Self.taskDateFormat)")
                .font(.caption)
                .frame(alignment: .topTrailing)
        }.padding(10)
        .background(Color.white)
    }
}
