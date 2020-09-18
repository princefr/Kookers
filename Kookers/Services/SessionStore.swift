//
//  SessionStore.swift
//  Kookers
//
//  Created by prince ONDONDA on 27/08/2020.
//  Copyright © 2020 prince ONDONDA. All rights reserved.
//  https://levelup.gitconnected.com/nearby-location-queries-with-cloud-firestore-e7f4a2f18f9d
//

import SwiftUI
import Combine
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift
import CoreLocation
import FirebaseStorage





class SessionStore: ObservableObject {
    var didChange = PassthroughSubject<SessionStore, Never>()
    @Published var session: User = User()
    var defaultvalue = User()
    @Published var is_user_new: Bool = false
    @Published var is_user_exist: Bool = false
    
    @Published var all_publications: [Publication] = [Publication]()
    @Published var home_publication: [Publication] = [Publication]()
    @Published var all_buyers_orders: [Order] = [Order]()
    @Published var all_seller_orders: [Order] = [Order]()
    
    @Published var chatrooms: [ChatRoom] = [ChatRoom]()
    
    
    let default_UserSettings: UserSettings = UserSettings(food_preferences: all_food_preferences, food_price_range: all_price_range, createdAt: Date(), updatedAt: Date(), notification_enabled: true)
    
    
    
    let db = Firestore.firestore()
    var handle: AuthStateDidChangeListenerHandle?
    

    let publicationRef = Firestore.firestore().collection("publication")
    let orderRef = Firestore.firestore().collection("Orders")
    let chatRoomRef = Firestore.firestore().collection("Chats")
    
    
    // Get a reference to the storage service using the default Firebase App
    let storageref = Storage.storage().reference()
    
    
    
    func listen() {
        handle = Auth.auth().addStateDidChangeListener({ (auth, user) in
            if let user = user {
                let docRef = self.db.collection("users").document(user.uid)
                docRef.getDocument { (document, error) in
                    let result = Result{try document!.data(as: User.self)}
                    switch result {
                    case .success(let user):
                          if let user = user {
                            self.is_user_exist = true
                            self.session = user
                            self.get_publication_near_user()
                            self.loadallpublication()
                            self.getAllOrders()
                            self.getSellerOrders()
                            self.loadAllChatRoom(loaded: {_ in
                                print("loaded")
                            })
                        } else {
                            // A nil value was successfully initialized from the DocumentSnapshot,
                            // or the DocumentSnapshot was nil.
                            //self.is_user_new = true
                            print("Document user does not exist")
                        }
                    case .failure(let error):
                        print("une erreur s'est produite veuiller reesayer")
                        // A `user` value could not be initialized from the DocumentSnapshot.
                        print("Error decoding city: \(error)")
                    }
                }
            } else {
                self.session = self.defaultvalue
                print("no session yet")
            }
        })
    }
    

    
    func signUp(email: String, password: String, handler: @escaping AuthDataResultCallback) {
        Auth.auth().createUser(withEmail: email, password: password, completion: handler)
    }
    
    
    func linkPhoneWithEmail(email: String, password: String){
        EmailAuthProvider.credential(withEmail: email, password: password)
    }

    func signIn(email: String, password: String, handler: @escaping AuthDataResultCallback) {
        Auth.auth().signIn(withEmail: email, password: password, completion: handler)
    }

    func signOut() {
        do {
            try Auth.auth().signOut()
            self.session = self.defaultvalue
        } catch {
            print("Error Signing Out")
        }
    }

    func unbind() {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }

    deinit {
        unbind()
    }
    
    
    func signWithCredential(verificationID: String, verificationCode: String , handler: @escaping AuthDataResultCallback) {
        let credential = PhoneAuthProvider.provider().credential(
        withVerificationID: verificationID,
        verificationCode: verificationCode)
        Auth.auth().signIn(with: credential, completion: handler)
    }
    
    
    func verifyphone(phonenumber: String, handler: @escaping VerificationResultCallback){
        PhoneAuthProvider.provider().verifyPhoneNumber(phonenumber, uiDelegate: nil, completion: handler)
    }
    
    
    func SaveNewUser(user: User) {
        do {
            try db.collection("user").document(user.uid).setData(from: user)
        } catch let error {
            print("Error writing user to Firestore: \(error)")
        }
    }
    
    
    func CheckIfUserExist(uid: String,  exist: @escaping (Bool?) -> Void){
        let docRef = self.db.collection("users").document(uid)
        docRef.getDocument { (document, error) in
            if let document = document,  document.exists {
                exist(true)
            }else{
                exist(false)
            }
        }
    }
    
    func update() {
        let docRef = self.db.collection("users").document(self.session.uid)
        do {
            try docRef.setData(from: session)
        } catch let error {
            print("Error writing user to Firestore: \(error)")
        }
    }
    
    
    func loadallpublication() {
        let query = publicationRef.whereField("SellerID", isEqualTo: self.session.uid)
        query.getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            }else{
                var allpub = [Publication]()
                for document in querySnapshot!.documents {
                   let result =  Result{try document.data(as: Publication.self)}
                    switch result {
                    case .success(let publi):
                        allpub.append(publi!)
                    case .failure(let error):
                        print(error)

                    }
                }
                
                self.all_publications = allpub
            }
        }
    }
    
    
    func get_publication_near_user() {
        let center = CLLocation(latitude: self.session.current_adress.lat, longitude: self.session.current_adress.long)
        let distanceMeters = Measurement(value: self.session.settings.distance_from_seller, unit: UnitLength.kilometers)
        let distanceMiles = distanceMeters.converted(to: UnitLength.miles)
        let (lower, upper) = center.geohashWhithinRange(distance: distanceMiles.value, length: 10)
        
        publicationRef.whereField("geo_hash", isGreaterThanOrEqualTo: lower)
            .whereField("geo_hash", isLessThanOrEqualTo: upper).getDocuments { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                }else{
                    
                    var allpub = [Publication]()
                    for document in querySnapshot!.documents {
                        let result =  Result{try document.data(as: Publication.self)}
                         switch result {
                         case .success(let publi):
                            publi?.loadImage()
                            allpub.append(publi!)
                         case .failure(let error):
                             print(error)

                         }
                    }
                    
                    print(allpub.count, "this is all publication")
                    
                    self.home_publication = allpub
                    
                }
        }

    }
    
    
    func OrderIncoming(order: Order){
        do {
            try self.orderRef.addDocument(from: order)
        } catch let error {
            print("Error writing user to Firestore: \(error)")
        }
    }
    
    
    func getAllOrders() {
        let query = self.orderRef.whereField("buyerID", isEqualTo: self.session.uid)
        query.getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            }else{
                var allpub = [Order]()
                for document in querySnapshot!.documents {
                   let result =  Result{try document.data(as: Order.self)}
                    switch result {
                    case .success(let publi):
                        allpub.append(publi!)
                    case .failure(let error):
                        print(error)

                    }
                }
                
                self.all_buyers_orders = allpub
            }
        }
    }
    
    
    func getSellerOrders() {
        let query = self.orderRef.whereField("sellerID", isEqualTo: self.session.uid)
        query.getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            }else{
                var allpub = [Order]()
                for document in querySnapshot!.documents {
                   let result =  Result{try document.data(as: Order.self)}
                    switch result {
                    case .success(let publi):
                        allpub.append(publi!)
                    case .failure(let error):
                        print(error)

                    }
                }
                
                self.all_seller_orders = allpub
            }
        }
    }
    
    
    func loadAllChatRoom(loaded: @escaping (Bool?) -> Void?) {
            chatRoomRef.whereField("users.\(self.session.uid)", isEqualTo:  true)
                .getDocuments { (querysnapshot, error) in
                    if let error = error {
                        print("j'ai mon error", error)
                    }else{
                        var all_rooms = [ChatRoom]()
                        for document in querysnapshot!.documents {
                            let result =  Result{try document.data(as: ChatRoom.self)}
                             switch result {
                             case .success(let room):
                                 all_rooms.append(room!)
                             case .failure(let error):
                                 print(error)

                             }
                        
                        }
                        
                        self.chatrooms = all_rooms
                        loaded(true)
                }
            }
        }
    
    
    
    func SendChat(roomID: String, message: Message, results: @escaping (Bool, Error?) -> Void){
        do {
            try chatRoomRef.document(roomID).collection("messages").addDocument(from: message)
            results(true, nil)
        } catch let error {
            results(false, error)
        }
        
    }
    
    
    func sendImages(publicationRef: String, images: [Data], url_callback: @escaping ([String]?) -> Void) {
        var urls: [String] = [String]()
        let myGroup = DispatchGroup()
        
        for image in images {
            myGroup.enter()
            let image_name = "\(NSUUID().uuidString).jpg"
            let imagesRef = storageref.child("Publications").child(publicationRef).child(image_name)
            _ = imagesRef.putData(image, metadata: nil) { (metadata, error) in
                guard let metadata = metadata else {
                  // Uh-oh, an error occurred!
                  return 
                }
                
                print("yes he suis la")
                

              // Download URL after upload.
                imagesRef.downloadURL { (url, error) in
                    guard let downloadURL = url else {return}
                    
                    
                print(downloadURL.absoluteString)
                let urlString = downloadURL.absoluteString
                urls.append(urlString)
                myGroup.leave()
              }
            }
        }
        
        myGroup.notify(queue: .main) {
            url_callback(urls)
            print("Finished all requests.")
        }
        
        
        
    }
    
    
    func loadImages(urls: [String], callback: @escaping ([Data], Error?) -> Void) {
        var all_images_data: [Data] = [Data]()
        var error_download: Error?
        for url in urls {
          // Create a reference to the file you want to download
          let imageRef = Storage.storage().reference(forURL: url)
          // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
            imageRef.getData(maxSize: 1 * 1024 * 1024) { (data, error) in
                if let error = error {
                    return error_download = error
                  // Uh-oh, an error occurred!
                } else {
                    all_images_data.append(data!)
                }
            }
        }
        
        if urls.count == all_images_data.count {
            callback(all_images_data, nil)
        }else{
            callback(all_images_data, error_download)
            
        }
        
        
        
    }


}



