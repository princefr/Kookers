//
//  ProductCell.swift
//  Kookers
//
//  Created by prince ONDONDA on 01/09/2020.
//  Copyright © 2020 prince ONDONDA. All rights reserved.
//

import SwiftUI
import ExyteGrid

struct ProductCell: View {
    @State var publication: Publication
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            PageView([CachedImage(
                url: self.publication.images_urls[0],
                placeholder: Image(uiImage: UIImage(named: "placeholder")!)
            ).aspectRatio(contentMode: .fill), CachedImage(
                url: self.publication.images_urls[1],
                placeholder: Image(uiImage: UIImage(named: "placeholder")!)
            ).aspectRatio(contentMode: .fill), CachedImage(
                url: self.publication.images_urls[2],
                placeholder: Image(uiImage: UIImage(named: "placeholder")!)
            ).aspectRatio(contentMode: .fill), CachedImage(
                url: self.publication.images_urls[3],
                placeholder: Image(uiImage: UIImage(named: "placeholder")!)
            ).aspectRatio(contentMode: .fill)])
                
            .frame(height: 300)
            .cornerRadius(10)
                .overlay(
                    HStack {
                        Text("15 €")
                            .foregroundColor(Color.white)
                            .padding(8)

                            Divider().frame(height: 10).foregroundColor(Color.white)
                        
                        HStack {
                            Image(systemName: "location").foregroundColor(Color.white).font(.caption)
                            Text("45 km").foregroundColor(Color.white)
                        }.padding(8)
                    }.background(Color(UIColor(hexString: "F95F5F")))
                     .padding([.top, .bottom], 4)
                     .padding([.leading, .trailing], 8)
                , alignment: .topLeading)


            
            
            VStack(alignment: .leading) {
                HStack(spacing: 10) {
                    Image(systemName: "heart").font(.title).foregroundColor(Color.gray).padding([.trailing], 10)
                    
                    Image(systemName: "arrow.up.right").font(.title)
                        .foregroundColor(Color.gray)
                        .padding([.trailing])
                    
                    Spacer()
                    
                    FiveStarPanelView().font(.caption)
                }
            }
            
            VStack(alignment: .leading, spacing: 6) {
                    Text(self.publication.title).foregroundColor(Color.gray)
                    Text(self.publication.description)
                    .font(Font.custom("HelveticaNeue-light", size: 16))
                    .foregroundColor(Color.gray)
                .lineLimit(2)
            }.padding(.top)
        }
    }
    
    func loadImages(images: [UIImage]) -> [PageViewImage] {
        var all_pagesviews_images: [PageViewImage] = [PageViewImage]()
        for image in images {
            all_pagesviews_images.append(PageViewImage(image: image))
        }
        return all_pagesviews_images

    }
}



struct PageViewImage: View {
    @State var image : UIImage
    var body: some View {
        Image(uiImage: image)
        .resizable()
        .renderingMode(.original)
        .scaledToFill()
    }
}




