//
//  File.swift
//  MyGitLab
//
//  Created by PHAM ANH TUAN on 15/06/2021.
//

import Foundation
import Firebase
import RxSwift

protocol DiscussionServiceType {
    func addDiscussion(_ discussion: MGLIssueDiscussion, issueId: String) -> Observable<Bool>
    func fetchDicussions(_ issueId: String) -> Observable<[MGLIssueDiscussion]>
    func didChangeDiscussions(_ issueId: String) -> Observable<[MGLIssueDiscussion]>
}

class FirestoreDiscussionService {
    
    static let `default` = FirestoreDiscussionService()
    
    let database = Firestore.firestore()
    var documentReference: DocumentReference?
    
    var lisenDicussionValueChangedReference: CollectionReference?
}

extension Encodable {
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw NSError()
        }
        return dictionary
    }
}

extension FirestoreDiscussionService: DiscussionServiceType {
    
    func addDiscussion(_ discussion: MGLIssueDiscussion, issueId: String) -> Observable<Bool> {
        
        guard let data = try? discussion.asDictionary() else { return .of(false) }
        
        let collectionReference = database.getIssuesChannelThreadReference(by: issueId)
        return collectionReference
            .rx
            .addDocument(data: data)
            .observe(on: MainScheduler.instance)
            .asObservable()
    }
    
    func fetchDicussions(_ issueId: String) -> Observable<[MGLIssueDiscussion]> {
        return database
            .getIssuesChannelThreadReference(by: issueId)
            .rx
            .getDocument()
            .observe(on: MainScheduler.instance)
            .asObservable()
            .map { [weak self] objects in
                objects.compactMap { [weak self] object in
                    guard let targetObject: MGLIssueDiscussion = try? self?.decodableFirestoreResponse(from: object) else { return nil }
                    return targetObject
                }
            }
    }
    
    func didChangeDiscussions(_ issueId: String) -> Observable<[MGLIssueDiscussion]> {
        lisenDicussionValueChangedReference = database.getIssuesChannelThreadReference(by: issueId)
        
        guard let reference = lisenDicussionValueChangedReference else { return Observable.of([]) }
        return reference
            .rx
            .addSnapshotListener()
            .observe(on: MainScheduler.instance)
            .asObservable()
            .map { [weak self] objects in
                objects.compactMap { [weak self] object in
                    guard let targetObject: MGLIssueDiscussion = try? self?.decodableFirestoreResponse(from: object) else { return nil }
                    return targetObject
                }
            }
    }
    
    private func decodableFirestoreResponse<T: Decodable>(from object: [String: Any]) throws -> T {
        let jsonData = try JSONSerialization.data(withJSONObject: object)
        return try JSONDecoder().decode(T.self, from: jsonData)
    }
}

extension Firestore {
    func getIssuesChannelThreadReference(by issueId: String) -> CollectionReference {
        return self.collection(["channels", issueId, "thread"].joined(separator: "/"))
    }
}

extension Reactive where Base: CollectionReference {
    func addDocument(data: [String: Any]) -> Single<Bool> {
        return Single.create { single -> Disposable in
            base.addDocument(data: data) { error in
                if let error = error {
                    single(.failure(error))
                } else {
                    single(.success(true))
                }
            }
            return Disposables.create()
        }
        .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
    }
    
    func getDocument() -> Single<[[String: Any]]> {
        return Single.create { single in
            base.getDocuments { snapshot, error in
                if let error = error {
                    single(.failure(error))
                } else if let snapshot = snapshot {
                    single(.success(snapshot.documents.map { $0.data() }))
                } else {
                    single(.success([]))
                }
            }
            return Disposables.create()
        }
        .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
    }
    
    func addSnapshotListener() -> Observable<[[String: Any]]> {
        return Observable.create { observable in
            let listen = base.addSnapshotListener { snapshot, error in
                if let error = error {
                    observable.onError(error)
                } else if let snapshot = snapshot {
                    observable.onNext(snapshot.documents.map { $0.data() })
                } else {
                    observable.onNext([])
                }
            }
            return Disposables.create {
                listen.remove()
            }
        }
        .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
    }
}

