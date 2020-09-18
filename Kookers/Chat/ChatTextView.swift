//
//  ChatTextView.swift
//  Kookers
//
//  Created by prince ONDONDA on 02/09/2020.
//  Copyright © 2020 prince ONDONDA. All rights reserved.
//

import SwiftUI

struct ChatTextView: View {
    @Binding var message_in_typing: String
    @Binding var height: CGFloat
    var send_button: () -> Void
    var pick_image_button: () -> Void
    
    var body: some View {
        HStack(spacing: 15) {
            HStack(spacing: 15){
                TextView(text: self.$message_in_typing, height: self.$height, placeholder: "Taper votre message").frame(height: self.height < 100 ? self.height : 100)
                
                Button(action: pick_image_button, label: {
                    
                    Image(systemName: "paperclip.circle.fill")
                        .font(.system(size: 22))
                        .foregroundColor(.gray)
                })
            }.padding(.vertical, 5)
             .padding(.horizontal)
             .background(Color.black.opacity(0.06))
             .clipShape(Capsule())
            
            
            // Send Button
            if message_in_typing != "" {
                Button(action: send_button, label: {
                    Image(systemName: "paperplane.fill")
                          .font(.system(size: 22))
                        .foregroundColor(Color.red)
                          // rotating the image...
                          .rotationEffect(.init(degrees: 45))
                          // adjusting padding shape...
                          .padding(.vertical,12)
                          .padding(.leading,12)
                          .padding(.trailing,17)
                          .background(Color.black.opacity(0.07))
                          .clipShape(Circle())
                })
            }
            
        }.padding(.horizontal)
    }
}
