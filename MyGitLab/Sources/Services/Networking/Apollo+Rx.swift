//
//  Apollo+Rx.swift
//  MyGitLab
//
//  Created by PHAM ANH TUAN on 12/06/2021.
//


import Foundation
import RxSwift
import Apollo

public enum RxApolloError: Error {
    case graphQLErrors([GraphQLError])
}

public final class ApolloReactiveExtensions {
    private let client: ApolloClient

    fileprivate init(_ client: ApolloClient) {
        self.client = client
    }
    
    public func fetch<Query: GraphQLQuery>(
        query: Query,
        cachePolicy: CachePolicy = .returnCacheDataAndFetch,
        queue: DispatchQueue = DispatchQueue.main) -> Maybe<Query.Data> {
        return Maybe.create { maybe in
            let cancellable = self.client.fetch(query: query, cachePolicy: cachePolicy, queue: queue) { result in
                
                switch result {
                case .success(let graphQLResult):
                    
                    if let queryData = graphQLResult.data {
                        maybe(.success(queryData))
                    } else if let errors = graphQLResult.errors {
                        maybe(.error(RxApolloError.graphQLErrors(errors)))
                    } else {
                        maybe(.completed)
                    }
                    
                case .failure(let error):
                    maybe(.error(error))
                }
            }

            return Disposables.create {
                cancellable.cancel()
            }
        }
    }
    
//    public func watch<Query: GraphQLQuery>(
//        query: Query,
//        cachePolicy: CachePolicy = .returnCacheDataElseFetch,
//        queue: DispatchQueue = DispatchQueue.main) -> Observable<Query.Data> {
//        return Observable.create { observer in
//            let watcher = self.client.watch(query: query, cachePolicy: cachePolicy, queue: queue) { result, error in
//                if let error = error {
//                    observer.onError(error)
//                } else if let errors = result?.errors {
//                    observer.onError(RxApolloError.graphQLErrors(errors))
//                } else if let data = result?.data {
//                    observer.onNext(data)
//                }
//
//                // Should we silently ignore the case where `result` and `error` are both nil, or should this be an error situation?
//            }
//
//            return Disposables.create {
//                watcher.cancel()
//            }
//        }
//    }
//
//    public func perform<Mutation: GraphQLMutation>(mutation: Mutation, queue: DispatchQueue = DispatchQueue.main) -> Maybe<Mutation.Data> {
//        return Maybe.create { maybe in
//            let cancellable = self.client.perform(mutation: mutation, queue: queue) { result, error in
//                if let error = error {
//                    maybe(.error(error))
//                } else if let errors = result?.errors {
//                    maybe(.error(RxApolloError.graphQLErrors(errors)))
//                } else if let data = result?.data {
//                    maybe(.success(data))
//                } else {
//                    maybe(.completed)
//                }
//            }
//
//            return Disposables.create {
//                cancellable.cancel()
//            }
//        }
//    }
}

public extension ApolloClient {
    /// Reactive extensions.
    var rx: ApolloReactiveExtensions { return ApolloReactiveExtensions(self) }
}
