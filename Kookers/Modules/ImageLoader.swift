//
//  ImageLoader.swift
//  Kookers
//https://github.com/bhlvoong/LBTAComponents/blob/b1af84727464e4f6e6fd311755dbeea7a45daead/LBTAComponents/Classes/CachedImageView.swift
//  Created by prince ONDONDA on 11/09/2020.
//  Copyright © 2020 prince ONDONDA. All rights reserved.
//  https://www.vadimbulavin.com/asynchronous-swiftui-image-loading-from-url-with-combine-and-swift/

import SwiftUI
import Combine
import Firebase
import FirebaseStorage
import FirebaseFirestore
import FirebaseFirestoreSwift


class ImageLoader: ObservableObject {
    public static let imageCache = NSCache<NSString, DiscardableImageCacheItem>()
    private(set) var isLoading = false
    
    let storage = Storage.storage()
    @Published var image: UIImage?
    private let url: String
    // Get a reference to the storage service using the default Firebase App
    
    init(fromUrl: String) {
        self.url = fromUrl
    }
    
    private var cancellable: AnyCancellable?
    
    
    func load() {
        if let cachedItem = ImageLoader.imageCache.object(forKey: self.url as NSString) {
            self.image = cachedItem.image
            return
        }
        
        self.onStart()
        let httpsReference = storage.reference(forURL: self.url)
        httpsReference.getData(maxSize: 1 * 1024 * 1024) { data, error in
          if let error = error {
            self.onFinish()
            print(error)
          } else {
            self.onFinish()
            let image_ = UIImage(data: data!)
            let cacheItem = DiscardableImageCacheItem(image: image_!)
            ImageLoader.imageCache.setObject(cacheItem, forKey: self.url as NSString)
            self.image = image_
          }
        }

    }
    
    
    deinit {
        cancellable?.cancel()
    }
    
    
    func cancel() {
        cancellable?.cancel()
    }
    
    private func onStart() {
        isLoading = true
    }
    
    private func onFinish() {
        isLoading = false
    }

}

struct CachedImage<Placeholder: View>: View {
    @ObservedObject private var loader: ImageLoader
    private let placeholder: Placeholder?
    
    init(url: String, placeholder: Placeholder? = nil) {
        loader = ImageLoader(fromUrl: url)
        self.placeholder = placeholder
    }

    var body: some View {
        image
            .onAppear(perform: loader.load)
            .onDisappear(perform: loader.cancel)
    }
    
    private var image: some View {
        Group {
            if loader.image != nil {
                Image(uiImage: loader.image!)
                    .renderingMode(.original)
                    .resizable()
            }else {
                placeholder
            }
        }
    }

}




open class DiscardableImageCacheItem: NSObject, NSDiscardableContent {
    private(set) public var image: UIImage?
    var accessCount: UInt = 0
    
    public init(image: UIImage) {
        self.image = image
    }
    
    public func beginContentAccess() -> Bool {
        if image == nil {
            return false
        }
        
        accessCount += 1
        return true
    }
    
    public func endContentAccess() {
        if accessCount > 0 {
            accessCount -= 1
        }
    }
    
    public func discardContentIfPossible() {
        if accessCount == 0 {
            image = nil
        }
    }
    
    public func isContentDiscarded() -> Bool {
        return image == nil
    }
    
}


