//
//  MGLIssueState.swift
//  MyGitLab
//
//  Created by PHAM ANH TUAN on 12/06/2021.
//

import Foundation

extension MilestoneStateEnum: MGLGrapQLMappable {
    func mapped() -> MGLIssue.Milestone.State {
        return .init(rawValue: rawValue).or(.active)
    }
}

extension MGLIssue {
    enum State: String, Codable {
        case opened
        case closed
        case merged
        case all
    }
}
