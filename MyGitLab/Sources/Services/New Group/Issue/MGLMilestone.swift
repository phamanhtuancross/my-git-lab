//
//  MGLMilestone.swift
//  MyGitLab
//
//  Created by PHAM ANH TUAN on 12/06/2021.
//

import Foundation

extension MGLIssue {
    struct Milestone: Codable {
        
        let state: State
        let dueDate: String?
        let iid: String
        let createAt: String?
        let updatedAt: String?
        let id: String
        
        enum State: String, Codable {
            case active
            case closed
        }
        
        private enum CodingKeys: String, CodingKey {
            case state, dueDate, iid, createAt, updatedAt, id
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            state = (try? container.decode(State.self, forKey: .state)).or(.active)
            dueDate = (try? container.decode(String.self, forKey: .dueDate))
            iid = (try? container.decode(String.self, forKey: .iid)).or("")
            createAt = (try? container.decode(String.self, forKey: .createAt))
            updatedAt = (try? container.decode(String.self, forKey: .updatedAt))
            id = (try? container.decode(String.self, forKey: .id)).or("")
        }
        
        init(state: State,
         dueDate: String?,
         iid: String,
         createAt: String?,
         updatedAt: String?,
         id: String) {
            self.dueDate = dueDate
            self.state = state
            self.iid = iid
            self.createAt = createAt
            self.updatedAt = updatedAt
            self.id = id
        }
    }
}


extension IssueListQuery.Data.Project.Issue.Node.Milestone: MGLGrapQLMappable {
    func mapped() -> MGLIssue.Milestone {
        return .init(
            state: state.mapped(),
            dueDate: dueDate,
            iid: iid,
            createAt: createdAt,
            updatedAt: updatedAt,
            id: id
        )
    }
}
