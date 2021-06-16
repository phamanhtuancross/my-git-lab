//
//  Optional+Extension.swift
//  MyGitLab
//
//  Created by PHAM ANH TUAN on 11/06/2021.
//

import Foundation

// MARK: - Extensions -
public extension Optional {

    func `or`(_ value: Wrapped?) -> Optional {
        return self ?? value
    }

    func `or`(_ value: Wrapped) -> Wrapped {
        return self ?? value
    }
}
