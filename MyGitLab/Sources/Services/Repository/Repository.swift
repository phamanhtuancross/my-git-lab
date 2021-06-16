//
//  Repository.swift
//  MyGitLab
//
//  Created by PHAM ANH TUAN on 14/06/2021.
//

import Foundation

protocol LocalDataModel: AnyObject {}
protocol RemoteDataModel: AnyObject {}

protocol DataModel: LocalDataModel, RemoteDataModel {}

enum FetchPolicy {
    case fetchRemoteFirstIfErrorFetchCache
}

protocol Repository {
}
