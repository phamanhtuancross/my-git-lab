//
//  File.swift
//  MyGitLab
//
//  Created by PHAM ANH TUAN on 15/06/2021.
//

import Foundation
import Firebase

protocol ChatServiceType {}

class FirestoreChatService {
    let database = Firestore.firestore()
}

extension FirestoreChatService: ChatServiceType {
    
}
