//
//  RoundedButtonView.swift
//  Kookers
//
//  Created by prince ONDONDA on 10/09/2020.
//  Copyright © 2020 prince ONDONDA. All rights reserved.
//

import SwiftUI

struct RoundedButtonView: View {
    var action : () -> Void
    @Binding var button_state: RoundedButtonState
    @Binding var inactive_text: String
    @Binding var loading_text: String
    
    var body: some View {
        Button(action: action, label: {
            if button_state == .inactive {
                HStack {
                    Text(self.inactive_text)
                        .fontWeight(.semibold)
                        .font(.custom("Saira-light", size: 20))
                }
            }else if button_state == .inprogress {
                HStack(spacing: 10) {
                    ActivityIndicator(style: .large, animate: .constant(true))
                    Text(self.loading_text).font(.custom("Saira-light", size: 20)).fontWeight(.semibold)
                    
                }
            }
            
            }).padding()
            .disabled(button_state == .inprogress ? true : false)
            .foregroundColor(.white)
            .background(Color(UIColor(hexString: "F95F5F")))
            .cornerRadius(30)
    }
}


struct ProgressRoundedBar: View {
    @Binding var progress: CGFloat // [0..1]

    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .trim(from: 0.0, to: CGFloat(progress))
            .stroke(Color.red, lineWidth: 2.0)
    }
}


enum RoundedButtonState {
    case inactive, inprogress
}


struct RoundedButtonView_Previews: PreviewProvider {
    static var previews: some View {
        Text("yes")
    }
}

struct ActivityIndicator: UIViewRepresentable {

    let style: UIActivityIndicatorView.Style
    @Binding var animate: Bool

    private let spinner: UIActivityIndicatorView = {
        $0.hidesWhenStopped = true
        return $0
    }(UIActivityIndicatorView(style: .medium))

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        spinner.style = style
        spinner.color = .white
        return spinner
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        animate ? uiView.startAnimating() : uiView.stopAnimating()
    }

    func configure(_ indicator: (UIActivityIndicatorView) -> Void) -> some View {
        indicator(spinner)
        return self
    }
}
