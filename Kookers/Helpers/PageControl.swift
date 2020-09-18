//
//  PageControl.swift
//  Kookers
//
//  Created by prince ONDONDA on 27/08/2020.
//  Copyright © 2020 prince ONDONDA. All rights reserved.
//


import SwiftUI

struct PageControl: UIViewRepresentable{
    var numberOfPages: Int
    @Binding var currentPage: Int
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> UIPageControl {
        let control = UIPageControl()
        control.pageIndicatorTintColor = UIColor.gray
        control.currentPageIndicatorTintColor =  UIColor.orange
        control.numberOfPages = numberOfPages
        
        control.addTarget(
            context.coordinator,
            action: #selector(Coordinator.updateCurrentPage(sender:)),
            for: .valueChanged)

        return control
    }

    func updateUIView(_ uiView: UIPageControl, context: Context) {
        uiView.currentPage = currentPage
    }
    
    class Coordinator: NSObject {
        var control: PageControl

        init(_ control: PageControl) {
            self.control = control
        }

        @objc func updateCurrentPage(sender: UIPageControl) {
            control.currentPage = sender.currentPage
        }
        
    }
}


