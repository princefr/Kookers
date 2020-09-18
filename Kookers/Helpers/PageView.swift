//
//  PageView.swift
//  Kookers
//
//  Created by prince ONDONDA on 27/08/2020.
//  Copyright © 2020 prince ONDONDA. All rights reserved.
//

import SwiftUI

struct PageView<Page: View>: View {
    var viewControllers: [UIHostingController<Page>]
    @State var currentPage = 0
    
    
    init(_ views: [Page]) {
        self.viewControllers = views.map { UIHostingController(rootView: $0) }
    }
    


    var body: some View {
        ZStack(alignment: .bottom) {
            PageViewController(controllers: viewControllers, currentPage: $currentPage)
            PageControl(numberOfPages: viewControllers.count, currentPage: $currentPage)
                .padding([.trailing])
        }
    }
}

struct PageView_Previews: PreviewProvider {
    static var previews: some View {
        PageView([Image("turtlerock")
            .interpolation(.none)
            .resizable()
            .aspectRatio(contentMode: .fit), Image("turtlerock")
                .interpolation(.none)
                .resizable()
                .aspectRatio(contentMode: .fit)]).aspectRatio(3/2, contentMode: .fit)
    }
}

