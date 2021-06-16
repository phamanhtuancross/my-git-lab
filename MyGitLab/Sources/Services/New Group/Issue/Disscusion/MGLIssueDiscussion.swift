//
//  MGLIssueDiscussion.swift
//  MyGitLab
//
//  Created by PHAM ANH TUAN on 13/06/2021.
//

import Foundation

struct MGLPageInfo: Hashable, Equatable {
    
    static let `default` = MGLPageInfo.init(hasNextPage: true, startCursor: "", endCursor: "", hasPreviousPage: false)
    
    let hasNextPage: Bool
    let startCursor: String
    let endCursor: String
    let hasPreviousPage: Bool
    
    init(hasNextPage: Bool, startCursor: String, endCursor: String, hasPreviousPage: Bool) {
        self.hasNextPage = hasNextPage
        self.startCursor = startCursor
        self.endCursor = endCursor
        self.hasPreviousPage = hasPreviousPage
    }
}

extension MGLPageInfo: Codable {
    enum CodingKeys: String, CodingKey {
        case hasNextPage
        case startCursor
        case endCursor
        case hasPreviousPage
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        hasNextPage = (try? container.decode(Bool.self, forKey: .hasNextPage)).or(true)
        startCursor = (try? container.decode(String.self, forKey: .startCursor)).or("")
        hasPreviousPage = (try? container.decode(Bool.self, forKey: .hasPreviousPage)).or(true)
        endCursor = (try? container.decode(String.self, forKey: .endCursor)).or("")
    }
}


struct MGLIssueDiscussion {
    let id: String
    let createdAt: String
    let replyId: String
    let resolvable: Bool
    let resolved: Bool
    let notes: MGLIssueDiscussionNotes
    
    init(id: String, createdAt: String, replyId: String, resolvable: Bool, resolved: Bool, notes: MGLIssueDiscussionNotes) {
        self.id = id
        self.createdAt = createdAt
        self.replyId = replyId
        self.resolvable = resolvable
        self.resolved = resolved
        self.notes = notes
    }
}

extension MGLIssueDiscussion: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case createdAt
        case replyId
        case resolvable
        case resolved
        case notes
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = (try? container.decode(String.self, forKey: .id)).or("")
        createdAt = (try? container.decode(String.self, forKey: .createdAt)).or("")
        replyId = (try? container.decode(String.self, forKey: .replyId)).or("")
        resolvable = (try? container.decode(Bool.self, forKey: .resolvable)).or(false)
        resolved = (try? container.decode(Bool.self, forKey: .resolved)).or(false)
        notes = (try? container.decode(MGLIssueDiscussionNotes.self, forKey: .notes)).or(.init(nodes: []))
    }
}

struct MGLIssueDiscussionsPagination {
    let pageInfo: MGLPageInfo
    let discussions: [MGLIssueDiscussion]
}

struct MGLIssueDiscussionNode {
    let author: MGLAuthor
    let id: String
    let body: String
    let bodyHtml: String?
    let createAt: String?
    let url: String?
    
    init(author: MGLAuthor, id: String, body: String, bodyHtml: String?, createAt: String?, url: String?) {
        self.author = author
        self.id = id
        self.body = body
        self.bodyHtml = bodyHtml
        self.createAt = createAt
        self.url = url
    }
}

extension MGLIssueDiscussionNode: Codable {
    enum CodingKeys: String, CodingKey {
        case author
        case id
        case body
        case bodyHtml
        case createAt
        case url
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        author = (try? container.decode(MGLAuthor.self, forKey: .author)).or(.init(state: .active, id: "", webUrl: "", name: "", avatarUrl: "", username: ""))
        id = (try? container.decode(String.self, forKey: .id)).or("")
        body = (try? container.decode(String.self, forKey: .body)).or("")
        bodyHtml = (try? container.decode(String.self, forKey: .bodyHtml))
        createAt = (try? container.decode(String.self, forKey: .createAt))
        url = (try? container.decode(String.self, forKey: .url))
    }
}

struct MGLIssueDiscussionNotes {
    let nodes: [MGLIssueDiscussionNode]
    
    init(nodes: [MGLIssueDiscussionNode]) {
        self.nodes = nodes
    }
}

extension MGLIssueDiscussionNotes: Codable {
    enum Codingkeys: String, CodingKey {
        case nodes
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Codingkeys.self)
        nodes = (try? container.decode([MGLIssueDiscussionNode].self, forKey: .nodes)).or([])
    }
}

extension DisscustionsQuery.Data.Project.Issue.Discussion.PageInfo: MGLGrapQLMappable {
    func mapped() -> MGLPageInfo {
        return .init(hasNextPage: hasNextPage, startCursor: startCursor.or(""), endCursor: endCursor.or(""), hasPreviousPage: hasPreviousPage)
    }
}

extension DisscustionsQuery.Data.Project.Issue.Discussion.Node.Note: MGLGrapQLMappable {
    func mapped() -> MGLIssueDiscussionNotes {
        return .init(nodes: (nodes.or([])).compactMap { $0?.mapped() })
    }
}

extension DisscustionsQuery.Data.Project.Issue.Discussion.Node: MGLGrapQLMappable {
    func mapped() -> MGLIssueDiscussion {
        return .init(
            id: id,
            createdAt: createdAt,
            replyId: replyId,
            resolvable: resolvable,
            resolved: resolved,
            notes: notes.mapped())
    }
}

extension DisscustionsQuery.Data.Project.Issue.Discussion.Node.Note.Node: MGLGrapQLMappable {
    func mapped() -> MGLIssueDiscussionNode {
        return .init(
            author: author.mapped(),
            id: id,
            body: body,
            bodyHtml: bodyHtml,
            createAt: createdAt,
            url: url
        )
    }
}

extension DisscustionsQuery.Data.Project.Issue.Discussion.Node.Note.Node.Author: MGLGrapQLMappable {
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

extension DisscustionsQuery.Data.Project.Issue.Discussion: MGLGrapQLMappable {
    func mapped() -> MGLIssueDiscussionsPagination {
        return .init(pageInfo: pageInfo.mapped(), discussions: (nodes).or([]).compactMap { $0?.mapped() })
    }
}
