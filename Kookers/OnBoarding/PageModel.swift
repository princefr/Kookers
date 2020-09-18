//
//  PageModel.swift
//  Kookers
//
//  Created by prince ONDONDA on 27/08/2020.
//  Copyright © 2020 prince ONDONDA. All rights reserved.
//

import SwiftUI

struct Page_Model : Identifiable {
    var id : Int
    var image : String
    var title : String
    var descrip : String
}

var Onboarding_Pages = [
    Page_Model(id: 0, image: "Chef-pana", title: "Chef amateur proche de vous", descrip: "Kookers vout met en relation avec des amoureux de la cuisine"),
    Page_Model(id: 1, image: "Messaging fun-pana", title: "Choisissez un plat savoureux", descrip: "We make it simple to find the food you crave. Enter your  home addresse and let us do the rest."),
    Page_Model(id: 2, image: "Pedestrian crossing-pana-2", title: "Allez chercher votre plat", descrip: "We make it simple to find the food you crave. Enter your  home addresse and let us do the rest."),
    Page_Model(id: 3, image: "Eating healthy food-pana", title: "Dégustez", descrip: "We make it simple to find the food you crave. Enter your  home addresse and let us do the rest.")
]
