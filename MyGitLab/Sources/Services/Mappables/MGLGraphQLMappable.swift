//
//  MGLGraphQLMappable.swift
//  MyGitLab
//
//  Created by PHAM ANH TUAN on 12/06/2021.
//

import Foundation

protocol MGLGrapQLMappable {
    
    associatedtype Model
    func mapped() -> Model
}
