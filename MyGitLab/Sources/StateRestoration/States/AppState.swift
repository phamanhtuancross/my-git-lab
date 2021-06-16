//
//  AppState.swift
//  MyGitLab
//
//  Created by PHAM ANH TUAN on 15/06/2021.
//

import UIKit

class AppState {
    var issueListActityState: IssueListActityState = .default
    public static let shared = AppState()
    private init() {}
}

extension AppState {
    enum Keys: String {
        case issuesListActivity
        case ativityType = "myGitLabActitityType"
    }
}


extension AppState {
    struct IssueListActityState: Hashable, Equatable, Codable {
        
        static let `default`: IssueListActityState = .init(tableContentOffsetY: 0)
        static func == (lhs: AppState.IssueListActityState, rhs: AppState.IssueListActityState) -> Bool {
            return lhs.tableContentOffsetY == rhs.tableContentOffsetY
        }
        
        let tableContentOffsetY: CGFloat
        let pageInfo: MGLPageInfo
        let latestViewModels: [DSIssueViewModel]

        init(tableContentOffsetY: CGFloat = .zero,
             pageInfo: MGLPageInfo = .default, l
                latestViewModels: [DSIssueViewModel] = []) {
            
            self.tableContentOffsetY = tableContentOffsetY
            self.pageInfo = pageInfo
            self.latestViewModels = latestViewModels
        }
        
        enum CodingKeys: String, CodingKey {
            case tableContentOffsetY
            case pageInfo
            case latestViewModels
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            tableContentOffsetY = (try? container.decode(CGFloat.self, forKey: .tableContentOffsetY)).or(.zero)
            pageInfo = (try? container.decode(MGLPageInfo.self, forKey: .pageInfo)).or(.default)
            latestViewModels = (try? container.decode([DSIssueViewModel].self, forKey: .latestViewModels)).or([])
        }
        
        func hash(into hasher: inout Hasher) {
            return hasher.combine(self)
        }
    }
}

extension AppState {
    
    func stored() -> NSUserActivity? {
        let activity = NSUserActivity(activityType: Keys.ativityType.rawValue)
        var userInfo: [AnyHashable: Any] = [:]
        
        if let data = try? JSONEncoder().encode(issueListActityState) {
            userInfo[Keys.issuesListActivity.rawValue] = data
        }
        
        activity.addUserInfoEntries(from: userInfo)
        
        return activity
    }
    
    func restore(from activity: NSUserActivity) {
        
        if let data = activity.userInfo?[Keys.issuesListActivity.rawValue] as? Data,
           let issueListActityState = try? JSONDecoder().decode(IssueListActityState.self, from: data) {
            self.issueListActityState = issueListActityState
        }
    }
}
