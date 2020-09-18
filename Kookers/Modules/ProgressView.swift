//
//  ProgressView.swift
//  Kookers
//
//  Created by prince ONDONDA on 02/09/2020.
//  Copyright © 2020 prince ONDONDA. All rights reserved.
//

import SwiftUI

struct ProgressViewR: ViewModifier {
    @Binding var percent: CGFloat
    @Binding var show:Bool
    
   func body(content: Content) -> some View {
    ZStack {
        content
        if show {
            VStack {
                ZStack(alignment: .leading) {
                    ZStack(alignment: .trailing) {
                        Rectangle().fill(Color.black.opacity(0.08)).frame(height:7)
                    }
                    
                    Rectangle().fill(Color.red).frame(width: self.calculatePurcentage(), height: 7)
                    
                    
                }.animation(.spring())
            }
        }

      }
    }
    
    
    func calculatePurcentage() -> CGFloat {
        let width = UIScreen.main.bounds.width
        return width * percent
    }
}


extension View {
    func loader(percent: Binding<CGFloat>, show: Binding<Bool>) -> some View {
        self.modifier(ProgressViewR(percent: percent, show: show))
    }
}

struct ProgressViewR_Previews: PreviewProvider {
    @State static var percent: CGFloat = 0.30
    @State static var show: Bool = true
    static var previews: some View {
        VStack {
            Spacer()
            Text("this is is")
            Spacer()
        }.loader(percent: $percent, show: $show)
    }
}
