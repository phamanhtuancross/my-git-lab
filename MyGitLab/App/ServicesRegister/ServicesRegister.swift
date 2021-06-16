//
//  ServicesRegister.swift
//  MyGitLab
//
//  Created by PHAM ANH TUAN on 12/06/2021.
//

import Foundation
import Resolver
import Firebase

extension Resolver {
    public static func registerMyGitLabServices() {
        
        register { MyGitLabService.default }
            .implements(MyGitLabServiceType.self)
        
        register { FirestoreDiscussionService.default }
            .implements(DiscussionServiceType.self)
        
        FirebaseApp.configure()
    }
}
