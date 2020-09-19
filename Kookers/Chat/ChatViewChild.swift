//
//  ChatViewChild.swift
//  Kookers
//
//  Created by prince ONDONDA on 02/09/2020.
//  Copyright © 2020 prince ONDONDA. All rights reserved.
//

import SwiftUI
import Introspect

struct ChatViewChild: View {
    @EnvironmentObject var session: SessionStore
    @ObservedObject var room: ChatRoom
    @State var keyboardHeight: CGFloat = 0
    @State var height: CGFloat = 0
    @ObservedObject private var keyboard = KeyboardResponder()
    @State var message_in_typing = ""
    @State var image_picker_is_active = false
    @State var image_downloaded : UIImage?
    private let scrollingProxy = ListScrollingProxy() // proxy helper
    
    @State var all_Messages = [
        MessageUp(id: "SDSD", message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua", is_user_connected: false, profilePic: "placeholder",  message_picture: nil, createdAt: Date()),
        MessageUp(id: "SD56", message: "this is the dawn message", is_user_connected: false, profilePic: "placeholder",  message_picture: nil, createdAt: Date()),
        MessageUp(id: "SD65", message: "this is the dawn message", is_user_connected: true, profilePic: "placeholder",  message_picture: nil, createdAt: Date()),
        MessageUp(id: "SD45", message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua", is_user_connected: true, profilePic: "placeholder",  message_picture: nil, createdAt: Date()),
        MessageUp(id: "SD76", message: "this is the dawn message", is_user_connected: true, profilePic: "placeholder",  message_picture: nil, createdAt: Date())
    ]

    
    var body: some View {
        ScrollViewReader { scrollingProxy in
            VStack(spacing: 0) {
                 ScrollView{
                    LazyVStack {
                        ForEach(0..<all_Messages.count, id: \.self) { i in
                                ChatBubble(message: all_Messages[i]).background(
                                    ListScrollingHelper(proxy: self.scrollingProxy)
                                ).id(i)
                            }
                        }.listRowInsets(.zero)
                        
                }
                .onTapGesture {
                    UIApplication.shared.windows.first?.rootViewController?.view.endEditing(true)
                }
                
                ChatTextView(message_in_typing: self.$message_in_typing, height: $height, send_button: {
                    self.all_Messages.append(MessageUp(id: String(all_Messages.count+1), message: self.message_in_typing, is_user_connected: true, profilePic: "placeholder", message_picture: nil, createdAt: Date()))
                    print(all_Messages.count, "i got it")
                    
                    withAnimation {
                        scrollingProxy.scrollTo(all_Messages.count-1)
                    }
                }) {
                    self.image_picker_is_active = true
                }.padding(.bottom, 10)
                .padding(.top, 10)
                .animation(.spring())
                .onTapGesture(perform: {
                    withAnimation {
                        scrollingProxy.scrollTo(all_Messages.count-1)
                    }
                })
                        
            }
            .navigationBarTitle("", displayMode: .inline)
            .background(Color.white)
            .sheet(isPresented: $image_picker_is_active) {
                ImagePicker(sourceType: UIImagePickerController.SourceType.photoLibrary) { uiimage in
                    print("ui image")
                }

            }
        }
    }
}




struct MessageUp: Identifiable, Equatable {
    var id: String
    var message : String
    var is_user_connected : Bool
    var profilePic : String
    var message_picture: Data?
    var createdAt: Date?
}




struct ChatViewChild_Previews: PreviewProvider {
    @State static var room: ChatRoom = ChatRoom()
    static var previews: some View {
        ChatViewChild(room: room)
    }
}




extension EdgeInsets {
    
    static var zero: EdgeInsets {
        .init(top: 15, leading: 5, bottom: 15, trailing: 5)
    }
    
}

struct Separator: View {
    let color: Color
    
    var body: some View {
        Divider()
            .overlay(color)
            .padding(.zero)
    }
    
    init(color: Color = Color("separator")) {
        self.color = color
    }
}
