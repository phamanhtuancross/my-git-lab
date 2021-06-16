//
//  MGLIssue.swift
//  MyGitLab
//
//  Created by PHAM ANH TUAN on 12/06/2021.
//

import Foundation

struct MGLIssuePagination {
    let pageInfo: MGLPageInfo
    let issues: [MGLIssue]
}

struct MGLIssue {
    
    static let `default` = MGLIssue.init(id: "", iid: "", state: .all, description: nil, title: "", author: nil, milestone: nil, upVotes: 0, downVotes: 0, userNotesCount: 0)
    
    
    let id: String
    let iid: String
    let state: State
    let description: String?
    let title: String
    let author: MGLAuthor?
    let milestone: Milestone?
    let upVotes: Int
    let downVotes: Int
    let userNotesCount: Int
    
    init(id: String,
         iid: String,
         state: State,
         description: String?,
         title: String,
         author: MGLAuthor?,
         milestone: Milestone?,
         upVotes: Int,
         downVotes: Int,
         userNotesCount: Int) {
        self.id = id
        self.iid = iid
        self.state = state
        self.description = description
        self.title = title
        self.author = author
        self.milestone = milestone
        self.upVotes = upVotes
        self.downVotes = downVotes
        self.userNotesCount = userNotesCount
    }
}

extension MGLIssue: Codable {
    private enum CodingKeys: String, CodingKey {
        case id, iid, state, title, author, milestone, upVotes, downVotes, userNotesCount
        case description = "issuesDescription"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = (try? container.decode(String.self, forKey: .id)).or("")
        iid = (try? container.decode(String.self, forKey: .iid)).or("")
        state = (try? container.decode(MGLIssue.State.self, forKey: .state)).or(.all)
        title = (try? container.decode(String.self, forKey: .title)).or("")
        description = (try? container.decode(String.self, forKey: .description))
        author = (try? container.decode(MGLAuthor.self, forKey: .author)).or(nil)
        milestone = (try? container.decode(MGLIssue.Milestone.self, forKey: .milestone)).or(nil)
        upVotes = (try? container.decode(Int.self, forKey: .upVotes)).or(0)
        downVotes = (try? container.decode(Int.self, forKey: .downVotes)).or(0)
        userNotesCount = (try? container.decode(Int.self, forKey: .userNotesCount)).or(0)
    }
}


extension IssueListQuery.Data.Project.Issue.Node: MGLGrapQLMappable {
    func mapped() -> MGLIssue {
        return .init(
            id: id,
            iid: iid,
            state: state.mapped(),
            description: description,
            title: title,
            author: author.mapped(),
            milestone: milestone?.mapped(),
            upVotes: upvotes,
            downVotes: downvotes,
            userNotesCount: 999
        )
    }
}

extension IssueState: MGLGrapQLMappable {
    func mapped() -> MGLIssue.State {
        return .init(rawValue: rawValue).or(.all)
    }
}

extension IssueListQuery.Data.Project.Issue: MGLGrapQLMappable {
    func mapped() -> MGLIssuePagination {
        return .init(pageInfo: pageInfo.mapped(), issues: (nodes.or([]).compactMap { $0?.mapped() }))
    }
}

extension IssueListQuery.Data.Project.Issue.PageInfo: MGLGrapQLMappable {
    func mapped() -> MGLPageInfo {
        return .init(hasNextPage: hasNextPage, startCursor: startCursor.or(""), endCursor: endCursor.or(""), hasPreviousPage: hasPreviousPage)
    }
}

