//
//  TextView.swift
//  Kookers
//
//  Created by prince ONDONDA on 02/09/2020.
//  Copyright © 2020 prince ONDONDA. All rights reserved.
//

import SwiftUI

struct TextView: UIViewRepresentable {
    
    @Binding var text: String
    @Binding var height: CGFloat
    @State var placeholder: String
    
    func makeCoordinator() -> Coordinator {
        return TextView.Coordinator(parent1: self)
    }
    
    
    func makeUIView(context: Context) -> UITextView {
        let view = UITextView()
        view.isEditable = true
        view.isScrollEnabled = true
        view.textColor = .lightGray
        view.text = self.placeholder
        view.font = .systemFont(ofSize: 18)
        view.backgroundColor = .clear
        view.delegate = context.coordinator
        return view
    }
    
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        DispatchQueue.main.async {
            self.height = uiView.contentSize.height
        }
    }
    
    
    class Coordinator: NSObject, UITextViewDelegate {
        var parent: TextView
        
        init(parent1: TextView) {
            parent = parent1
        }
        
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            if self.parent.text == "" {
                textView.text = ""
                textView.textColor = UIColor.black
            }
        }
        
        
        func textViewDidEndEditing(_ textView: UITextView) {
            if self.parent.text == "" {
                textView.text = self.parent.placeholder
                textView.textColor = UIColor.lightGray
            }
        }
        
        

        
        func textViewDidChange(_ textView: UITextView) {
            DispatchQueue.main.async {
                self.parent.height = textView.contentSize.height
                self.parent.text = textView.text
            }
        }
    }
}


final class KeyboardResponder: ObservableObject {
    private var notificationCenter: NotificationCenter
    @Published private(set) var currentHeight: CGFloat = 0

    init(center: NotificationCenter = .default) {
        notificationCenter = center
        notificationCenter.addObserver(self, selector: #selector(keyBoardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyBoardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    deinit {
        notificationCenter.removeObserver(self)
    }

    @objc func keyBoardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            currentHeight = keyboardSize.height
        }
    }

    @objc func keyBoardWillHide(notification: Notification) {
        currentHeight = 0
    }
}
