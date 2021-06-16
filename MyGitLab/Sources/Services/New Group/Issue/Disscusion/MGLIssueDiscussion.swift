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
}

struct MGLIssueDiscussionNotes {
    let nodes: [MGLIssueDiscussionNode]
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
