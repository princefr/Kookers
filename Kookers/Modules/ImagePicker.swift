//
//  ImagePicker.swift
//  Kookers
//
//  Created by prince ONDONDA on 29/08/2020.
//  Copyright © 2020 prince ONDONDA. All rights reserved.
//

import SwiftUI

import SwiftUI
import Combine


class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    let parent: ImagePicker

    init(_ parent: ImagePicker) {
        self.parent = parent
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let uiImage = info[.originalImage] as? UIImage {
            parent.callback(uiImage)
        }

        parent.presentationMode.wrappedValue.dismiss()
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    @State var sourceType: UIImagePickerController.SourceType
    var callback: (UIImage) -> Void
    
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
            let picker = UIImagePickerController()
            picker.delegate = context.coordinator
            picker.sourceType = sourceType
            return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {

    }
}

///  how to use it
//.sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
//    ImagePicker(image: self.$inputImage)
//}

/// func loadImage() {
 //   guard let inputImage = inputImage else { return }
  //  image = Image(uiImage: inputImage)
//}
