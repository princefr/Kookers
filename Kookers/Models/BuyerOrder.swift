//
//  BuyerOrder.swift
//  Kookers
//
//  Created by prince ONDONDA on 01/09/2020.
//  Copyright © 2020 prince ONDONDA. All rights reserved.
//

import SwiftUI

class Order: ObservableObject, Codable, Identifiable {
    @Published var uid: String
    @Published var ProductID: String
    @Published var StripeTransactionID: String
    @Published var quantity: Double
    @Published var retrieveDate: Date
    @Published var total_price: Double
    @Published var createdAt: Date
    @Published var updateAt: Date
    @Published var buyerID: String
    
    
    enum CodingKeys: String, CodingKey {
        case uid, ProductID, StripeTransactionID, quantity, retrieveDate, total_price, createdAt, updateAt, buyerID
    }
    
    init() {
        self.uid = ""
        self.ProductID = ""
        self.StripeTransactionID = ""
        self.quantity = 1
        self.retrieveDate = Date()
        self.total_price = 0
        self.createdAt = Date()
        self.updateAt = Date()
        self.buyerID = ""
    }
    
    init(uid: String, productid: String, transactionid: String, quantity: Double, retrieveDate: Date, total_price: Double, buyerID: String) {
        self.uid  = uid
        self.ProductID = productid
        self.StripeTransactionID = transactionid
        self.quantity = quantity
        self.retrieveDate = retrieveDate
        self.total_price = total_price
        self.createdAt = Date()
        self.updateAt = Date()
        self.buyerID = buyerID
    }
    
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        uid = try container.decode(String.self, forKey: .uid)
        ProductID = try container.decode(String.self, forKey: .ProductID)
        StripeTransactionID = try container.decode(String.self, forKey: .StripeTransactionID)
        quantity = try container.decode(Double.self, forKey: .quantity)
        retrieveDate = try container.decode(Date.self, forKey: .retrieveDate)
        total_price = try container.decode(Double.self, forKey: .total_price)
        createdAt = try container.decode(Date.self, forKey: .createdAt)
        updateAt = try container.decode(Date.self, forKey: .updateAt)
        buyerID = try container.decode(String.self, forKey: .buyerID)
    }
    
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(uid, forKey: .uid)
        try container.encode(ProductID, forKey: .ProductID)
        try container.encode(StripeTransactionID, forKey: .StripeTransactionID)
        try container.encode(quantity, forKey: .quantity)
        try container.encode(retrieveDate, forKey: .retrieveDate)
        try container.encode(total_price, forKey: .total_price)
        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(updateAt, forKey: .updateAt)
        try container.encode(buyerID, forKey: .buyerID)
    }
}


enum OrderState: String, Decodable, Equatable, CaseIterable {
    case waiting, accepted, refused, done, rated
    var localizedName: LocalizedStringKey { LocalizedStringKey(rawValue) }
}

enum TransactionState: String, Decodable, Equatable, CaseIterable {
    case captured, cashed, refunded, seller_cashed
    var localizedName: LocalizedStringKey { LocalizedStringKey(rawValue) }
}
