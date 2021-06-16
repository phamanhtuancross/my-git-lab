//
//  MGLAuthor.swift
//  MyGitLab
//
//  Created by PHAM ANH TUAN on 12/06/2021.
//

import Foundation

extension IssueListQuery.Data.Project.Issue.Node.Author: MGLGrapQLMappable {
    func mapped() -> MGLAuthor {
        return .init(
            state: state.mapped(),
            id: id,
            webUrl: webUrl,
            name: name,
            avatarUrl: avatarUrl,
            username: username
        )
    }
}

extension UserState: MGLGrapQLMappable {
    func mapped() -> MGLAuthor.UserState {
        return .init(rawValue: rawValue).or(.active)
    }
}

struct MGLAuthor: Codable {
    
    let state: UserState
    let id: String
    let webUrl: String
    let name: String
    let avatarUrl: String?
    let username: String
    
    enum UserState: String, Codable {
        case active
        case blocked
        case deactivated
    }
    
    private enum CodingKeys: String, CodingKey {
        case state, id, webUrl, name, avatarUrl, username
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        state = (try? container.decode(UserState.self, forKey: .state)).or(.active)
        id = (try? container.decode(String.self, forKey: .id)).or("")
        webUrl = (try? container.decode(String.self, forKey: .webUrl)).or("")
        name = (try? container.decode(String.self, forKey: .name)).or("")
        avatarUrl = (try? container.decode(String.self, forKey: .avatarUrl))
        username = (try? container.decode(String.self, forKey: .username)).or("")
    }
    
    init(state: UserState,
         id: String,
         webUrl: String,
         name: String,
         avatarUrl: String?,
         username: String) {
        self.state = state
        self.id = id
        self.webUrl = webUrl
        self.name = name
        self.avatarUrl = avatarUrl
        self.username = username
    }
}
