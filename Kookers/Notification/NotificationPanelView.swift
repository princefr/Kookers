//
//  NotificationPanelView.swift
//  Kookers
//
//  Created by prince ONDONDA on 10/09/2020.
//  Copyright © 2020 prince ONDONDA. All rights reserved.
//

import SwiftUI




struct NotificationPanelView: ViewModifier {
    @Binding var data:PanelData
    @Binding var show:Bool
    
    func body(content: Content) -> some View {
        ZStack {
            content
            
            if show {
                VStack {
                    HStack {
                        // Banner Content Here
                        VStack(alignment: .leading, spacing: 2) {
                            Text(data.title)
                                .bold()
                            Text(data.detail)
                                .font(Font.system(size: 15, weight: Font.Weight.light, design: Font.Design.default))
                        }
                        
                        Spacer()
                    }.foregroundColor(Color.white)
                    .padding(12)
                    .background(data.type.tintColor)
                    .cornerRadius(8)
                    Spacer()
                }.padding()
                .animation(.easeInOut)
                .transition(AnyTransition.move(edge: .top).combined(with: .opacity))
                .onTapGesture {
                    withAnimation {
                        self.show = false
                    }
                }.onAppear(perform: {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                        withAnimation {
                            self.show = false
                        }
                    }
                })
            }
        }
    }
    
}


enum PanelType {
    case Info
    case Warning
    case Success
    case Error

    var tintColor: Color {
        switch self {
        case .Info:
            return Color(red: 67/255, green: 154/255, blue: 215/255)
        case .Success:
            return Color.green
        case .Warning:
            return Color.yellow
        case .Error:
            return Color.red
        }
    }
}


struct PanelData {
    var title:String
    var detail:String
    var type: PanelType
}


extension View {
    func banner(data: Binding<PanelData>, show: Binding<Bool>) -> some View {
        self.modifier(NotificationPanelView(data: data, show: show))
    }
}

struct NotificationPanelView_Previews: PreviewProvider {
    @State static var showBanner:Bool = false
    @State static var panel_test = PanelData(title: "this is it", detail: "il faut que tu fasse ça", type: .Warning)
    static var previews: some View {
        VStack(alignment: .center, spacing: 4) {
            Button(action: {
                print("info banner")
                self.panel_test.type = .Info
                self.showBanner = true
            }) {
                Text("[ Info Banner ]")
            }
            Button(action: {
                self.panel_test.type = .Success
                self.showBanner = true
            }) {
                Text("[ Success Banner ]")
            }
            Button(action: {
                self.panel_test.type = .Warning
                self.showBanner = true
            }) {
                Text("[ Warning Banner ]")
            }
            Button(action: {
                self.panel_test.type = .Error
                self.showBanner = true
            }) {
                Text("[ Error Banner ]")
            }
        }.banner(data: $panel_test, show: $showBanner)
    }
}

