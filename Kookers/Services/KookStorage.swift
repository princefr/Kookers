//
//  KookStorage.swift
//  Kookers
//
//  Created by prince ONDONDA on 29/08/2020.
//  Copyright © 2020 prince ONDONDA. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseStorage
import FirebaseFirestoreSwift

class KookStorage {
    
    let UserImageRef = Storage.storage().reference().child("users_image")
    let PublicationImageRef = Storage.storage().reference().child("publication")
    
    
    func publish_user_image(imageData : Data, user_ref: String, url_callback: @escaping (String) -> Void){
        let dataref = UserImageRef.child(user_ref+".jpg")
        let uploadTask = dataref.putData(imageData)
        uploadTask.observe(.success) { snapshot in
            dataref.downloadURL { (url, error) in
                  guard let downloadURL = url else {
                      return
                 }
                url_callback(downloadURL.absoluteString)
                
            }
        }
    }
    
    
    func download_user_image(userRef: String, picture_data: @escaping (Data) -> Void){
        let dataref = UserImageRef.child(userRef+".jpg")
        dataref.getData(maxSize: 1 * 300 * 300) { (data, error) in
            if let error = error {
                print("\(error)")
            }

            picture_data(data!)
        }
        
    }
}
