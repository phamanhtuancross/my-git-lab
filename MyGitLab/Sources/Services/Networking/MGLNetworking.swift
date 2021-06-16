//
//  MGLNetworking.swift
//  MyGitLab
//
//  Created by PHAM ANH TUAN on 12/06/2021.
//

import Foundation
import Apollo
import SQLite

class MGLApolo {
    
    static let shared = MGLApolo()
    
    let client: ApolloClient
    private init() {
        
        guard let url = URL(string: Natrium.gitLabGraphQLAPIBase) else {
            fatalError("Could not intialization GraphQL client with invalid url string")
        }
        
        guard let documentsPath = NSSearchPathForDirectoriesInDomains(
            .documentDirectory,
            .userDomainMask,
                true).first else {
            client = ApolloClient(url: url)
            return
        }
        
        let documentsURL = URL(fileURLWithPath: documentsPath)
        let sqliteFileURL = documentsURL.appendingPathComponent(Natrium.appStorageSQLiteFileName)

        guard let sqliteCache = try? SQLiteNormalizedCache(fileURL: sqliteFileURL) else {
            client = ApolloClient(url: url)
            return
        }
        
        debugPrint("SQLite File Path: \(sqliteFileURL)")
        
        let store = ApolloStore(cache: sqliteCache)
        let provider = LegacyInterceptorProvider(store: store)
        let networkTransport = RequestChainNetworkTransport(interceptorProvider: provider,
                                                     endpointURL: url)
        
        client = ApolloClient(networkTransport: networkTransport, store: store)
    }
}
