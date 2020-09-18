//
//  ChatViewChild.swift
//  Kookers
//
//  Created by prince ONDONDA on 02/09/2020.
//  Copyright © 2020 prince ONDONDA. All rights reserved.
//

import SwiftUI

struct ChatViewChild: View {
    @EnvironmentObject var session: SessionStore
    @ObservedObject var room: ChatRoom
    @State var keyboardHeight: CGFloat = 0
    @State var height: CGFloat = 0
    @ObservedObject private var keyboard = KeyboardResponder()
    @State var message_in_typing = ""
    @State var image_picker_is_active = false
    @State var image_downloaded : UIImage?
    
    var body: some View {
        VStack {

                
                
            Spacer()
            ChatTextView(message_in_typing: $message_in_typing, height: $height, send_button: {
                let message = Message(uid: "", createdAt: Date(), message: self.message_in_typing, profilepic: "", message_picture: nil)
                self.session.SendChat(roomID: self.room.uid, message: message) { (sended, error) in
                    if let error = error {
                        print("i've found an error", error)
                    }else{
                        print("djks")
                    }
                }
            }) {
                self.image_picker_is_active = true
            }.padding(.bottom, keyboard.currentHeight - 15)
            .animation(.spring())
                    
        }.sheet(isPresented: $image_picker_is_active) {
            ImagePicker(sourceType: UIImagePickerController.SourceType.photoLibrary) { uiimage in
                print("ui image")
            }

        }
        .onTapGesture {
            UIApplication.shared.windows.first?.rootViewController?.view.endEditing(true)
        }
    }
}

struct ChatViewChild_Previews: PreviewProvider {
    @State static var room: ChatRoom = ChatRoom()
    static var previews: some View {
        ChatViewChild(room: room)
    }
}
