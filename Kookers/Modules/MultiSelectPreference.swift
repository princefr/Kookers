//
//  MultiSelectPreference.swift
//  Kookers
//
//  Created by prince ONDONDA on 31/08/2020.
//  Copyright © 2020 prince ONDONDA. All rights reserved.
//

import SwiftUI


struct FoodPreferenceRow: View {
    @ObservedObject var single_preference: FoodPreferences
    var action: () -> Void
    var body: some View {
        Button(action: self.action) {
            Text(single_preference.title)
                .foregroundColor(single_preference.is_selected == true ? Color.white : Color.gray)
                .font(Font.custom("Saira-Light", size: 15))
            .padding(10)
        }
        .background(single_preference.is_selected == true ? Color(UIColor(hexString: "F95F5F")): Color.gray.opacity(0.2))
            .clipShape(Rectangle())
            .cornerRadius(10)
            .animation(.linear)
            
        .padding(5)
    }
}


struct MultiSelectPreference: View {
    @State var all_preferences: [FoodPreferences]
    var body: some View {
        ScrollView (.horizontal, showsIndicators: false){
            HStack {
                ForEach(self.all_preferences) { preference in
                    FoodPreferenceRow(single_preference: preference) {
                        preference.toogle()
                    }
                }

            }
        }
    }
}

struct MultiSelectPreference_Previews: PreviewProvider {
    @State static var all_preferences = all_food_preferences
    static var previews: some View {
        MultiSelectPreference(all_preferences: all_preferences)
    }
}
