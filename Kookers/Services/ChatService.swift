//
//  ChatService.swift
//  Kookers
//
//  Created by prince ONDONDA on 01/09/2020.
//  Copyright © 2020 prince ONDONDA. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift


class ChatService {
    
    let chatRoomRef = Firestore.firestore().collection("Chats")
    
    
    func create_chatrom(users: [String], room_to_create: ChatRoom, chatroom: @escaping (ChatRoom) -> Void) {
        chatRoomRef
            .whereField("users.\(users[0])", isEqualTo: true)
            .whereField("users.\(users[1])", isEqualTo: true)
            .limit(to: 1)
            .getDocuments { (querySnapshot, error) in
            if querySnapshot!.count > 0 {
                let result =  Result{try querySnapshot!.documents[0].data(as: ChatRoom.self)}
                 switch result {
                 case .success(let room):
                    chatroom(room!)
                 case .failure(let error):
                     print(error)

                 }
                print("a chat was found ")
                // querySnapshot?.documents.m
            }else{
                do {
                    try self.chatRoomRef.addDocument(from: room_to_create).getDocument(completion: { (documentSnapshot, error) in
                        if let error = error {
                            print("dsdsd", error)
                        }else{
                            let result =  Result{try documentSnapshot!.data(as: ChatRoom.self)}
                            switch result {
                            case .success(let room):
                               chatroom(room!)
                            case .failure(let error):
                                print(error)

                            }
                        }
                    })
                } catch let error {
                   print("this is my error", error)
                }
                // tu crees le chatid
                
            }
            
        }
    }
    
    
    func addChat(chatroomID: String, message: Message) {
        do {
           try chatRoomRef.document(chatroomID).collection("messages").addDocument(from: message)
        } catch let error {
            print("error", error)
        }
        
    }
    
    
    func loadAllChatRoom(user_id: String) {
        chatRoomRef.whereField("users.\(user_id)", isEqualTo:  true)
            .getDocuments { (querysnapshot, error) in
                if let error = error {
                    print("j'ai mon error", error)
                }else{
                    var all_messages = [ChatRoom]()
                    for document in querysnapshot!.documents {
                        let result =  Result{try document.data(as: ChatRoom.self)}
                         switch result {
                         case .success(let room):
                             all_messages.append(room!)
                         case .failure(let error):
                             print(error)

                         }
                    
                    }
                }
        }
    }
    
    func loadMessages(chatroom_id: String) {
        chatRoomRef.document(chatroom_id).collection("messages").addSnapshotListener { (querysnapshot, error) in
            querysnapshot?.documents
        }
    }
}
