//
//  Network.swift
//  Kookers
//
//  Created by prince ONDONDA on 09/09/2020.
//  Copyright © 2020 prince ONDONDA. All rights reserved.
//

import Foundation
import Apollo



class Network {
    static let shared = Network()
    /// A web socket transport to use for subscriptions
    private lazy var webSocketTransport: WebSocketTransport = {
      let url = URL(string: "ws://localhost:4000/websocket")!
      let request = URLRequest(url: url)
      return WebSocketTransport(request: request)
    }()
    
    /// An HTTP transport to use for queries and mutations
    private lazy var httpTransport: HTTPNetworkTransport = {
      let url = URL(string: "http://localhost:4000/graphql")!
      return HTTPNetworkTransport(url: url)
    }()

    /// A split network transport to allow the use of both of the above
    /// transports through a single `NetworkTransport` instance.
    private lazy var splitNetworkTransport = SplitNetworkTransport(
      httpNetworkTransport: self.httpTransport,
      webSocketNetworkTransport: self.webSocketTransport
    )
    
    /// Create a client using the `SplitNetworkTransport`.
    private(set) lazy var client = ApolloClient(networkTransport: self.splitNetworkTransport)
}
