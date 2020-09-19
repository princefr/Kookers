//
//  ChatBubble.swift
//  Kookers
//
//  Created by prince ONDONDA on 19/09/2020.
//  Copyright © 2020 prince ONDONDA. All rights reserved.
//

import SwiftUI

struct ChatBubble: View {
    var message: MessageUp
    var body: some View {
        HStack(alignment: .top,spacing: 10) {
            if message.is_user_connected {
                Spacer(minLength: 15)
                VStack(spacing:5) {
                    if message.message_picture == nil {
                        
                        Text(message.message)
                            .padding(.all)
                            .background(Color.black.opacity(0.06))
                            .clipShape(MessageBubbleShape(is_user_connected_message: message.is_user_connected))
                    }
                    else{
                        
                        Image(uiImage: UIImage(data: message.message_picture!)!)
                            .resizable()
                            .frame(width: UIScreen.main.bounds.width - 150, height: 150)
                            .clipShape(MessageBubbleShape(is_user_connected_message: message.is_user_connected))
                    }
                    
                    Text("\(message.createdAt!)").font(.caption)
                }
                
                // profile Image...
                
                Image(message.profilePic)
                    .resizable()
                    .frame(width:50, height: 50)
                    .clipShape(Circle())
            }else{
                
                Image(message.profilePic)
                    .resizable()
                    .frame(width:50, height: 50)
                    .clipShape(Circle())
                
                
                VStack(spacing:5) {
                    
                    if message.message_picture == nil{
                        Text(message.message)
                            .foregroundColor(.white)
                            .padding(.all)
                            .background(Color(UIColor(hexString: "F95F5F")))
                            .clipShape(MessageBubbleShape(is_user_connected_message: message.is_user_connected))
                    }
                    else{
                        
                        Image(uiImage: UIImage(data: message.message_picture!)!)
                            .resizable()
                            .frame(width: UIScreen.main.bounds.width - 150, height: 150)
                            .clipShape(MessageBubbleShape(is_user_connected_message: message.is_user_connected))
                    }
                    
                    Text("\(message.createdAt!)").font(.caption)
                }
                

                
                
                Spacer(minLength: 15)
                
            }
            
        }
    }
}

struct ChatBubble_Previews: PreviewProvider {
    @State static var message: MessageUp = MessageUp(id: "SDSD", message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua", is_user_connected: false, profilePic: "turtlerock",  message_picture: nil)
    static var previews: some View {
        ChatBubble(message: message)
    }
}



// shape for message bubble
struct MessageBubbleShape : Shape {
    var is_user_connected_message : Bool
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: is_user_connected_message ?  [.topLeft,.bottomLeft,.bottomRight] : [.topRight,.bottomLeft,.bottomRight], cornerRadii: CGSize(width: 10, height: 10))
        
        return Path(path.cgPath)
    }
}
