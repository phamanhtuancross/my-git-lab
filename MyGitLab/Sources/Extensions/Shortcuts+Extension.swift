//
//  Shortcuts+Extension.swift
//  MyGitLab
//
//  Created by PHAM ANH TUAN on 13/06/2021.
//

import RxSwift
import RxCocoa

// MARK: - RxSwift

public extension ObservableType {

    func doOnNext(_ onNext: @escaping (Element) throws -> Void) -> Observable<Element> {
        return self.do(onNext: onNext)
    }

    func doOnError(_ onError: @escaping (Swift.Error) throws -> Void) -> Observable<Element> {
        return self.do(onError: onError)
    }

    func doOnCompleted(_ onCompleted: @escaping () throws -> Void) -> Observable<Element> {
        return self.do(onCompleted: onCompleted)
    }

    func subscribeNext(_ onNext: @escaping (Element) -> Void) -> Disposable {
        return self.subscribe(onNext: onNext)
    }

    func subscribeError(_ onError: @escaping (Swift.Error) -> Void) -> Disposable {
        return self.subscribe(onError: onError)
    }

    func subscribeCompleted(_ onCompleted: @escaping () -> Void) -> Disposable {
        return self.subscribe(onCompleted: onCompleted)
    }
}

// MARK: - RxCocoa

public extension SharedSequenceConvertibleType where SharingStrategy == DriverSharingStrategy {

    func doOnNext(_ onNext: @escaping (Element) -> Void) -> Driver<Element> {
        return self.do(onNext: onNext)
    }

    func doOnCompleted(_ onCompleted: @escaping () -> Void) -> Driver<Element> {
        return self.do(onCompleted: onCompleted)
    }

    func driveNext(_ onNext: @escaping (Element) -> Void) -> Disposable {
        return self.drive(onNext: onNext)
    }

    func driveCompleted(_ onCompleted: @escaping () -> Void) -> Disposable {
        return self.drive(onCompleted: onCompleted)
    }
}
