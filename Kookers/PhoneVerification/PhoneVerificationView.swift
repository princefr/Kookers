//
//  PhoneVerificationView.swift
//  Kookers
//
//  Created by prince ONDONDA on 27/08/2020.
//  Copyright © 2020 prince ONDONDA. All rights reserved.
//

import SwiftUI
import Firebase

struct PhoneVerificationView: View {
    @State var button_text = "Vérifier le code"
    @State var number = ""
    @State var current_country: Country = Country(id: "France", dialcode: "+33", code: "FR")
    @State var choose_country_view_is_open: Bool = false
    
    @State var code = ""
    @State var code_is_sent: Bool = false
    @State var code_button_text = "Envoyer le code"
    @State var code_sent_count = 0
    @State private var timeRemaining = 60
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    
    @ObservedObject var sessionStore: SessionStore = SessionStore()

    
    var body: some View {
        ZStack {
            VStack (spacing: 10) {
                Text("Vérifier votre numéro de téléphone").font(.title).fontWeight(.heavy)
                
                Text("Veuillez renseigner votre numéro de téléphone pour vous connecter à votre compte ou vous inscrire")
                    .font(.body)
                    .fontWeight(.light)
                    .foregroundColor(.gray)
                    .padding([.top, .bottom], 10)
                

                TextWithCountry(text: $number, current_country: $current_country) {
                    self.choose_country_view_is_open.toggle()
                }
                
                
                
                
                PhoneCodeTextView(text: $code, number_: $number, codeSent: $code_is_sent, button_code_text: $code_button_text) {
                    
                    self.AskNotificationPermission { success, error in
                        if success{
                            self.sessionStore.verifyphone(phonenumber: self.current_country.dialcode +  self.number) { (verificationID, error) in
                                self.code_is_sent = true
                                self.code_sent_count+=1
                                print("code sent " + String(self.code_sent_count))
                                if let error = error {
                                  print(error.localizedDescription)
                                  return
                                }
                                
                                UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
                            }
                        }else{
                            print("you need to activate notification")
                            
                        }
                    }
                }
                
                Spacer()
                
                
                
            }.padding(.top)
            .onReceive(timer) { time in
                if self.code_is_sent == true && self.timeRemaining > 0 {
                    self.timeRemaining -= 1
                    self.code_button_text = String(self.timeRemaining) + " secondes"
                }else if self.code_sent_count > 0  {
                    self.code_button_text = "Renvoyer le code"
                    self.code_is_sent = false
                    self.timeRemaining = 60
                }else {
                    self.code_button_text = "Envoyer le code"
                }
            }
            
            
            // button
            VStack {
                Spacer()
                    HStack {
                     Spacer()
                        RoundLeftButton(button_text: self.button_text) {
                            let verificationID = UserDefaults.standard.string(forKey: "authVerificationID")
                            self.sessionStore.signWithCredential(verificationID: verificationID!, verificationCode: self.code) { (authResult, error) in
                                if let error = error {
                                    print(error)
                                }
                                
                                guard let authResult = authResult else { return }
                                authResult.user.getIDTokenForcingRefresh(true) { idToken, error in
                                  if let error = error {
                                    // Handle error
                                    return;
                                  }

                                    let parameter: [String: String] = ["id": authResult.user.uid, "access_token" : idToken!]
                                    
                             self.sessionStore.CheckIfUserExist(uid: authResult.user.uid) { exist in
                                              if exist! {
                                                  self.sessionStore.is_user_exist = true
                                             }else{
                                                  self.sessionStore.is_user_new = true
                                              }
                                          }

                                }

                            }
                        }
                    }.padding(.top, 10)
            }
            
            
            NavigationLink(destination: TabedView().environmentObject(self.sessionStore), isActive: self.$sessionStore.is_user_exist) {
                EmptyView()
            }
            
            NavigationLink(destination: SignUpWithEmailView().environmentObject(self.sessionStore), isActive: self.$sessionStore.is_user_new) {
                EmptyView()
            }
        }
        .sheet(isPresented: $choose_country_view_is_open) {
            CountryPickerView(Chosed_country: self.$current_country, is_coountry_picker_active: self.$choose_country_view_is_open)
        }.edgesIgnoringSafeArea([.bottom])
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .navigationBarTitle("")
        .onTapGesture {
            self.hideKeyboard()
        }
    }
    
    
    func AskNotificationPermission(completionHandler: @escaping (Bool, Error?) -> Void) {
        let center = UNUserNotificationCenter.current()
        let settings: UNAuthorizationOptions = UNAuthorizationOptions(arrayLiteral: [.alert, .badge, .sound])
        center.requestAuthorization(options: settings, completionHandler: completionHandler)
        
    }
}

struct PhoneVerificationView_Previews: PreviewProvider {
    static var previews: some View {
        PhoneVerificationView()
    }
}


extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}



