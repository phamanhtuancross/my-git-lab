// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// State of a GitLab issue
public enum IssueState: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// In open state.
  case opened
  /// In closed state.
  case closed
  /// Discussion has been locked.
  case locked
  /// All available.
  case all
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "opened": self = .opened
      case "closed": self = .closed
      case "locked": self = .locked
      case "all": self = .all
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .opened: return "opened"
      case .closed: return "closed"
      case .locked: return "locked"
      case .all: return "all"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: IssueState, rhs: IssueState) -> Bool {
    switch (lhs, rhs) {
      case (.opened, .opened): return true
      case (.closed, .closed): return true
      case (.locked, .locked): return true
      case (.all, .all): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [IssueState] {
    return [
      .opened,
      .closed,
      .locked,
      .all,
    ]
  }
}

/// Possible states of a user
public enum UserState: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// The user is active and is able to use the system.
  case active
  /// The user has been blocked and is prevented from using the system.
  case blocked
  /// The user is no longer active and is unable to use the system.
  case deactivated
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "active": self = .active
      case "blocked": self = .blocked
      case "deactivated": self = .deactivated
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .active: return "active"
      case .blocked: return "blocked"
      case .deactivated: return "deactivated"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: UserState, rhs: UserState) -> Bool {
    switch (lhs, rhs) {
      case (.active, .active): return true
      case (.blocked, .blocked): return true
      case (.deactivated, .deactivated): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [UserState] {
    return [
      .active,
      .blocked,
      .deactivated,
    ]
  }
}

/// Current state of milestone
public enum MilestoneStateEnum: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// Milestone is currently active.
  case active
  /// Milestone is closed.
  case closed
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "active": self = .active
      case "closed": self = .closed
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .active: return "active"
      case .closed: return "closed"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: MilestoneStateEnum, rhs: MilestoneStateEnum) -> Bool {
    switch (lhs, rhs) {
      case (.active, .active): return true
      case (.closed, .closed): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [MilestoneStateEnum] {
    return [
      .active,
      .closed,
    ]
  }
}

public final class IssueListQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query IssueList($gitlabRepository: ID!, $first: Int!, $after: String!) {
      project(fullPath: $gitlabRepository) {
        __typename
        name
        issues(first: $first, after: $after) {
          __typename
          pageInfo {
            __typename
            hasNextPage
            startCursor
            endCursor
            hasPreviousPage
          }
          nodes {
            __typename
            id
            iid
            state
            description
            title
            upvotes
            downvotes
            author {
              __typename
              state
              id
              webUrl
              name
              avatarUrl
              username
            }
            milestone {
              __typename
              description
              state
              dueDate
              iid
              createdAt
              title
              updatedAt
              id
            }
          }
        }
      }
    }
    """

  public let operationName: String = "IssueList"

  public var gitlabRepository: GraphQLID
  public var first: Int
  public var after: String

  public init(gitlabRepository: GraphQLID, first: Int, after: String) {
    self.gitlabRepository = gitlabRepository
    self.first = first
    self.after = after
  }

  public var variables: GraphQLMap? {
    return ["gitlabRepository": gitlabRepository, "first": first, "after": after]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("project", arguments: ["fullPath": GraphQLVariable("gitlabRepository")], type: .object(Project.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(project: Project? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "project": project.flatMap { (value: Project) -> ResultMap in value.resultMap }])
    }

    /// Find a project.
    public var project: Project? {
      get {
        return (resultMap["project"] as? ResultMap).flatMap { Project(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "project")
      }
    }

    public struct Project: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Project"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("name", type: .nonNull(.scalar(String.self))),
          GraphQLField("issues", arguments: ["first": GraphQLVariable("first"), "after": GraphQLVariable("after")], type: .object(Issue.selections)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(name: String, issues: Issue? = nil) {
        self.init(unsafeResultMap: ["__typename": "Project", "name": name, "issues": issues.flatMap { (value: Issue) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// Name of the project (without namespace).
      public var name: String {
        get {
          return resultMap["name"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }

      /// Issues of the project.
      public var issues: Issue? {
        get {
          return (resultMap["issues"] as? ResultMap).flatMap { Issue(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "issues")
        }
      }

      public struct Issue: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["IssueConnection"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("pageInfo", type: .nonNull(.object(PageInfo.selections))),
            GraphQLField("nodes", type: .list(.object(Node.selections))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(pageInfo: PageInfo, nodes: [Node?]? = nil) {
          self.init(unsafeResultMap: ["__typename": "IssueConnection", "pageInfo": pageInfo.resultMap, "nodes": nodes.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// Information to aid in pagination.
        public var pageInfo: PageInfo {
          get {
            return PageInfo(unsafeResultMap: resultMap["pageInfo"]! as! ResultMap)
          }
          set {
            resultMap.updateValue(newValue.resultMap, forKey: "pageInfo")
          }
        }

        /// A list of nodes.
        public var nodes: [Node?]? {
          get {
            return (resultMap["nodes"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Node?] in value.map { (value: ResultMap?) -> Node? in value.flatMap { (value: ResultMap) -> Node in Node(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }, forKey: "nodes")
          }
        }

        public struct PageInfo: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["PageInfo"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("hasNextPage", type: .nonNull(.scalar(Bool.self))),
              GraphQLField("startCursor", type: .scalar(String.self)),
              GraphQLField("endCursor", type: .scalar(String.self)),
              GraphQLField("hasPreviousPage", type: .nonNull(.scalar(Bool.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(hasNextPage: Bool, startCursor: String? = nil, endCursor: String? = nil, hasPreviousPage: Bool) {
            self.init(unsafeResultMap: ["__typename": "PageInfo", "hasNextPage": hasNextPage, "startCursor": startCursor, "endCursor": endCursor, "hasPreviousPage": hasPreviousPage])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// When paginating forwards, are there more items?
          public var hasNextPage: Bool {
            get {
              return resultMap["hasNextPage"]! as! Bool
            }
            set {
              resultMap.updateValue(newValue, forKey: "hasNextPage")
            }
          }

          /// When paginating backwards, the cursor to continue.
          public var startCursor: String? {
            get {
              return resultMap["startCursor"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "startCursor")
            }
          }

          /// When paginating forwards, the cursor to continue.
          public var endCursor: String? {
            get {
              return resultMap["endCursor"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "endCursor")
            }
          }

          /// When paginating backwards, are there more items?
          public var hasPreviousPage: Bool {
            get {
              return resultMap["hasPreviousPage"]! as! Bool
            }
            set {
              resultMap.updateValue(newValue, forKey: "hasPreviousPage")
            }
          }
        }

        public struct Node: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Issue"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
              GraphQLField("iid", type: .nonNull(.scalar(GraphQLID.self))),
              GraphQLField("state", type: .nonNull(.scalar(IssueState.self))),
              GraphQLField("description", type: .scalar(String.self)),
              GraphQLField("title", type: .nonNull(.scalar(String.self))),
              GraphQLField("upvotes", type: .nonNull(.scalar(Int.self))),
              GraphQLField("downvotes", type: .nonNull(.scalar(Int.self))),
              GraphQLField("author", type: .nonNull(.object(Author.selections))),
              GraphQLField("milestone", type: .object(Milestone.selections)),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: GraphQLID, iid: GraphQLID, state: IssueState, description: String? = nil, title: String, upvotes: Int, downvotes: Int, author: Author, milestone: Milestone? = nil) {
            self.init(unsafeResultMap: ["__typename": "Issue", "id": id, "iid": iid, "state": state, "description": description, "title": title, "upvotes": upvotes, "downvotes": downvotes, "author": author.resultMap, "milestone": milestone.flatMap { (value: Milestone) -> ResultMap in value.resultMap }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// ID of the issue.
          public var id: GraphQLID {
            get {
              return resultMap["id"]! as! GraphQLID
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          /// Internal ID of the issue.
          public var iid: GraphQLID {
            get {
              return resultMap["iid"]! as! GraphQLID
            }
            set {
              resultMap.updateValue(newValue, forKey: "iid")
            }
          }

          /// State of the issue.
          public var state: IssueState {
            get {
              return resultMap["state"]! as! IssueState
            }
            set {
              resultMap.updateValue(newValue, forKey: "state")
            }
          }

          /// Description of the issue.
          public var description: String? {
            get {
              return resultMap["description"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "description")
            }
          }

          /// Title of the issue.
          public var title: String {
            get {
              return resultMap["title"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "title")
            }
          }

          /// Number of upvotes the issue has received.
          public var upvotes: Int {
            get {
              return resultMap["upvotes"]! as! Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "upvotes")
            }
          }

          /// Number of downvotes the issue has received.
          public var downvotes: Int {
            get {
              return resultMap["downvotes"]! as! Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "downvotes")
            }
          }

          /// User that created the issue.
          public var author: Author {
            get {
              return Author(unsafeResultMap: resultMap["author"]! as! ResultMap)
            }
            set {
              resultMap.updateValue(newValue.resultMap, forKey: "author")
            }
          }

          /// Milestone of the issue.
          public var milestone: Milestone? {
            get {
              return (resultMap["milestone"] as? ResultMap).flatMap { Milestone(unsafeResultMap: $0) }
            }
            set {
              resultMap.updateValue(newValue?.resultMap, forKey: "milestone")
            }
          }

          public struct Author: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["UserCore"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("state", type: .nonNull(.scalar(UserState.self))),
                GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                GraphQLField("webUrl", type: .nonNull(.scalar(String.self))),
                GraphQLField("name", type: .nonNull(.scalar(String.self))),
                GraphQLField("avatarUrl", type: .scalar(String.self)),
                GraphQLField("username", type: .nonNull(.scalar(String.self))),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(state: UserState, id: GraphQLID, webUrl: String, name: String, avatarUrl: String? = nil, username: String) {
              self.init(unsafeResultMap: ["__typename": "UserCore", "state": state, "id": id, "webUrl": webUrl, "name": name, "avatarUrl": avatarUrl, "username": username])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            /// State of the user.
            public var state: UserState {
              get {
                return resultMap["state"]! as! UserState
              }
              set {
                resultMap.updateValue(newValue, forKey: "state")
              }
            }

            /// ID of the user.
            public var id: GraphQLID {
              get {
                return resultMap["id"]! as! GraphQLID
              }
              set {
                resultMap.updateValue(newValue, forKey: "id")
              }
            }

            /// Web URL of the user.
            public var webUrl: String {
              get {
                return resultMap["webUrl"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "webUrl")
              }
            }

            /// Human-readable name of the user.
            public var name: String {
              get {
                return resultMap["name"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "name")
              }
            }

            /// URL of the user's avatar.
            public var avatarUrl: String? {
              get {
                return resultMap["avatarUrl"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "avatarUrl")
              }
            }

            /// Username of the user. Unique within this instance of GitLab.
            public var username: String {
              get {
                return resultMap["username"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "username")
              }
            }
          }

          public struct Milestone: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["Milestone"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("description", type: .scalar(String.self)),
                GraphQLField("state", type: .nonNull(.scalar(MilestoneStateEnum.self))),
                GraphQLField("dueDate", type: .scalar(String.self)),
                GraphQLField("iid", type: .nonNull(.scalar(GraphQLID.self))),
                GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                GraphQLField("title", type: .nonNull(.scalar(String.self))),
                GraphQLField("updatedAt", type: .nonNull(.scalar(String.self))),
                GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(description: String? = nil, state: MilestoneStateEnum, dueDate: String? = nil, iid: GraphQLID, createdAt: String, title: String, updatedAt: String, id: GraphQLID) {
              self.init(unsafeResultMap: ["__typename": "Milestone", "description": description, "state": state, "dueDate": dueDate, "iid": iid, "createdAt": createdAt, "title": title, "updatedAt": updatedAt, "id": id])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            /// Description of the milestone.
            public var description: String? {
              get {
                return resultMap["description"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "description")
              }
            }

            /// State of the milestone.
            public var state: MilestoneStateEnum {
              get {
                return resultMap["state"]! as! MilestoneStateEnum
              }
              set {
                resultMap.updateValue(newValue, forKey: "state")
              }
            }

            /// Timestamp of the milestone due date.
            public var dueDate: String? {
              get {
                return resultMap["dueDate"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "dueDate")
              }
            }

            /// Internal ID of the milestone.
            public var iid: GraphQLID {
              get {
                return resultMap["iid"]! as! GraphQLID
              }
              set {
                resultMap.updateValue(newValue, forKey: "iid")
              }
            }

            /// Timestamp of milestone creation.
            public var createdAt: String {
              get {
                return resultMap["createdAt"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "createdAt")
              }
            }

            /// Title of the milestone.
            public var title: String {
              get {
                return resultMap["title"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "title")
              }
            }

            /// Timestamp of last milestone update.
            public var updatedAt: String {
              get {
                return resultMap["updatedAt"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "updatedAt")
              }
            }

            /// ID of the milestone.
            public var id: GraphQLID {
              get {
                return resultMap["id"]! as! GraphQLID
              }
              set {
                resultMap.updateValue(newValue, forKey: "id")
              }
            }
          }
        }
      }
    }
  }
}

public final class DisscustionsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query Disscustions($gitlabRepository: ID!, $issueID: String!, $first: Int!, $after: String!) {
      project(fullPath: $gitlabRepository) {
        __typename
        name
        issue(iid: $issueID) {
          __typename
          discussions(first: $first, after: $after) {
            __typename
            pageInfo {
              __typename
              hasNextPage
              startCursor
              endCursor
              hasPreviousPage
            }
            nodes {
              __typename
              id
              createdAt
              replyId
              resolvable
              resolved
              resolvedBy {
                __typename
                avatarUrl
              }
              resolvedAt
              notes {
                __typename
                nodes {
                  __typename
                  id
                  author {
                    __typename
                    avatarUrl
                    name
                    username
                    id
                    state
                    webUrl
                  }
                  body
                  bodyHtml
                  createdAt
                  url
                }
              }
            }
          }
        }
      }
    }
    """

  public let operationName: String = "Disscustions"

  public var gitlabRepository: GraphQLID
  public var issueID: String
  public var first: Int
  public var after: String

  public init(gitlabRepository: GraphQLID, issueID: String, first: Int, after: String) {
    self.gitlabRepository = gitlabRepository
    self.issueID = issueID
    self.first = first
    self.after = after
  }

  public var variables: GraphQLMap? {
    return ["gitlabRepository": gitlabRepository, "issueID": issueID, "first": first, "after": after]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("project", arguments: ["fullPath": GraphQLVariable("gitlabRepository")], type: .object(Project.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(project: Project? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "project": project.flatMap { (value: Project) -> ResultMap in value.resultMap }])
    }

    /// Find a project.
    public var project: Project? {
      get {
        return (resultMap["project"] as? ResultMap).flatMap { Project(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "project")
      }
    }

    public struct Project: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Project"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("name", type: .nonNull(.scalar(String.self))),
          GraphQLField("issue", arguments: ["iid": GraphQLVariable("issueID")], type: .object(Issue.selections)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(name: String, issue: Issue? = nil) {
        self.init(unsafeResultMap: ["__typename": "Project", "name": name, "issue": issue.flatMap { (value: Issue) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// Name of the project (without namespace).
      public var name: String {
        get {
          return resultMap["name"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }

      /// A single issue of the project.
      public var issue: Issue? {
        get {
          return (resultMap["issue"] as? ResultMap).flatMap { Issue(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "issue")
        }
      }

      public struct Issue: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Issue"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("discussions", arguments: ["first": GraphQLVariable("first"), "after": GraphQLVariable("after")], type: .nonNull(.object(Discussion.selections))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(discussions: Discussion) {
          self.init(unsafeResultMap: ["__typename": "Issue", "discussions": discussions.resultMap])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// All discussions on this noteable.
        public var discussions: Discussion {
          get {
            return Discussion(unsafeResultMap: resultMap["discussions"]! as! ResultMap)
          }
          set {
            resultMap.updateValue(newValue.resultMap, forKey: "discussions")
          }
        }

        public struct Discussion: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["DiscussionConnection"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("pageInfo", type: .nonNull(.object(PageInfo.selections))),
              GraphQLField("nodes", type: .list(.object(Node.selections))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(pageInfo: PageInfo, nodes: [Node?]? = nil) {
            self.init(unsafeResultMap: ["__typename": "DiscussionConnection", "pageInfo": pageInfo.resultMap, "nodes": nodes.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// Information to aid in pagination.
          public var pageInfo: PageInfo {
            get {
              return PageInfo(unsafeResultMap: resultMap["pageInfo"]! as! ResultMap)
            }
            set {
              resultMap.updateValue(newValue.resultMap, forKey: "pageInfo")
            }
          }

          /// A list of nodes.
          public var nodes: [Node?]? {
            get {
              return (resultMap["nodes"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Node?] in value.map { (value: ResultMap?) -> Node? in value.flatMap { (value: ResultMap) -> Node in Node(unsafeResultMap: value) } } }
            }
            set {
              resultMap.updateValue(newValue.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }, forKey: "nodes")
            }
          }

          public struct PageInfo: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["PageInfo"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("hasNextPage", type: .nonNull(.scalar(Bool.self))),
                GraphQLField("startCursor", type: .scalar(String.self)),
                GraphQLField("endCursor", type: .scalar(String.self)),
                GraphQLField("hasPreviousPage", type: .nonNull(.scalar(Bool.self))),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(hasNextPage: Bool, startCursor: String? = nil, endCursor: String? = nil, hasPreviousPage: Bool) {
              self.init(unsafeResultMap: ["__typename": "PageInfo", "hasNextPage": hasNextPage, "startCursor": startCursor, "endCursor": endCursor, "hasPreviousPage": hasPreviousPage])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            /// When paginating forwards, are there more items?
            public var hasNextPage: Bool {
              get {
                return resultMap["hasNextPage"]! as! Bool
              }
              set {
                resultMap.updateValue(newValue, forKey: "hasNextPage")
              }
            }

            /// When paginating backwards, the cursor to continue.
            public var startCursor: String? {
              get {
                return resultMap["startCursor"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "startCursor")
              }
            }

            /// When paginating forwards, the cursor to continue.
            public var endCursor: String? {
              get {
                return resultMap["endCursor"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "endCursor")
              }
            }

            /// When paginating backwards, are there more items?
            public var hasPreviousPage: Bool {
              get {
                return resultMap["hasPreviousPage"]! as! Bool
              }
              set {
                resultMap.updateValue(newValue, forKey: "hasPreviousPage")
              }
            }
          }

          public struct Node: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["Discussion"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("id", type: .nonNull(.scalar(String.self))),
                GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                GraphQLField("replyId", type: .nonNull(.scalar(String.self))),
                GraphQLField("resolvable", type: .nonNull(.scalar(Bool.self))),
                GraphQLField("resolved", type: .nonNull(.scalar(Bool.self))),
                GraphQLField("resolvedBy", type: .object(ResolvedBy.selections)),
                GraphQLField("resolvedAt", type: .scalar(String.self)),
                GraphQLField("notes", type: .nonNull(.object(Note.selections))),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(id: String, createdAt: String, replyId: String, resolvable: Bool, resolved: Bool, resolvedBy: ResolvedBy? = nil, resolvedAt: String? = nil, notes: Note) {
              self.init(unsafeResultMap: ["__typename": "Discussion", "id": id, "createdAt": createdAt, "replyId": replyId, "resolvable": resolvable, "resolved": resolved, "resolvedBy": resolvedBy.flatMap { (value: ResolvedBy) -> ResultMap in value.resultMap }, "resolvedAt": resolvedAt, "notes": notes.resultMap])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            /// ID of this discussion.
            public var id: String {
              get {
                return resultMap["id"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "id")
              }
            }

            /// Timestamp of the discussion's creation.
            public var createdAt: String {
              get {
                return resultMap["createdAt"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "createdAt")
              }
            }

            /// ID used to reply to this discussion.
            public var replyId: String {
              get {
                return resultMap["replyId"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "replyId")
              }
            }

            /// Indicates if the object can be resolved.
            public var resolvable: Bool {
              get {
                return resultMap["resolvable"]! as! Bool
              }
              set {
                resultMap.updateValue(newValue, forKey: "resolvable")
              }
            }

            /// Indicates if the object is resolved.
            public var resolved: Bool {
              get {
                return resultMap["resolved"]! as! Bool
              }
              set {
                resultMap.updateValue(newValue, forKey: "resolved")
              }
            }

            /// User who resolved the object.
            public var resolvedBy: ResolvedBy? {
              get {
                return (resultMap["resolvedBy"] as? ResultMap).flatMap { ResolvedBy(unsafeResultMap: $0) }
              }
              set {
                resultMap.updateValue(newValue?.resultMap, forKey: "resolvedBy")
              }
            }

            /// Timestamp of when the object was resolved.
            public var resolvedAt: String? {
              get {
                return resultMap["resolvedAt"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "resolvedAt")
              }
            }

            /// All notes in the discussion.
            public var notes: Note {
              get {
                return Note(unsafeResultMap: resultMap["notes"]! as! ResultMap)
              }
              set {
                resultMap.updateValue(newValue.resultMap, forKey: "notes")
              }
            }

            public struct ResolvedBy: GraphQLSelectionSet {
              public static let possibleTypes: [String] = ["UserCore"]

              public static var selections: [GraphQLSelection] {
                return [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("avatarUrl", type: .scalar(String.self)),
                ]
              }

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public init(avatarUrl: String? = nil) {
                self.init(unsafeResultMap: ["__typename": "UserCore", "avatarUrl": avatarUrl])
              }

              public var __typename: String {
                get {
                  return resultMap["__typename"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "__typename")
                }
              }

              /// URL of the user's avatar.
              public var avatarUrl: String? {
                get {
                  return resultMap["avatarUrl"] as? String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "avatarUrl")
                }
              }
            }

            public struct Note: GraphQLSelectionSet {
              public static let possibleTypes: [String] = ["NoteConnection"]

              public static var selections: [GraphQLSelection] {
                return [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("nodes", type: .list(.object(Node.selections))),
                ]
              }

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public init(nodes: [Node?]? = nil) {
                self.init(unsafeResultMap: ["__typename": "NoteConnection", "nodes": nodes.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }])
              }

              public var __typename: String {
                get {
                  return resultMap["__typename"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "__typename")
                }
              }

              /// A list of nodes.
              public var nodes: [Node?]? {
                get {
                  return (resultMap["nodes"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Node?] in value.map { (value: ResultMap?) -> Node? in value.flatMap { (value: ResultMap) -> Node in Node(unsafeResultMap: value) } } }
                }
                set {
                  resultMap.updateValue(newValue.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }, forKey: "nodes")
                }
              }

              public struct Node: GraphQLSelectionSet {
                public static let possibleTypes: [String] = ["Note"]

                public static var selections: [GraphQLSelection] {
                  return [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("id", type: .nonNull(.scalar(String.self))),
                    GraphQLField("author", type: .nonNull(.object(Author.selections))),
                    GraphQLField("body", type: .nonNull(.scalar(String.self))),
                    GraphQLField("bodyHtml", type: .scalar(String.self)),
                    GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                    GraphQLField("url", type: .scalar(String.self)),
                  ]
                }

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public init(id: String, author: Author, body: String, bodyHtml: String? = nil, createdAt: String, url: String? = nil) {
                  self.init(unsafeResultMap: ["__typename": "Note", "id": id, "author": author.resultMap, "body": body, "bodyHtml": bodyHtml, "createdAt": createdAt, "url": url])
                }

                public var __typename: String {
                  get {
                    return resultMap["__typename"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// ID of the note.
                public var id: String {
                  get {
                    return resultMap["id"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "id")
                  }
                }

                /// User who wrote this note.
                public var author: Author {
                  get {
                    return Author(unsafeResultMap: resultMap["author"]! as! ResultMap)
                  }
                  set {
                    resultMap.updateValue(newValue.resultMap, forKey: "author")
                  }
                }

                /// Content of the note.
                public var body: String {
                  get {
                    return resultMap["body"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "body")
                  }
                }

                /// The GitLab Flavored Markdown rendering of `note`
                public var bodyHtml: String? {
                  get {
                    return resultMap["bodyHtml"] as? String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "bodyHtml")
                  }
                }

                /// Timestamp of the note creation.
                public var createdAt: String {
                  get {
                    return resultMap["createdAt"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "createdAt")
                  }
                }

                /// URL to view this Note in the Web UI.
                public var url: String? {
                  get {
                    return resultMap["url"] as? String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "url")
                  }
                }

                public struct Author: GraphQLSelectionSet {
                  public static let possibleTypes: [String] = ["UserCore"]

                  public static var selections: [GraphQLSelection] {
                    return [
                      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                      GraphQLField("avatarUrl", type: .scalar(String.self)),
                      GraphQLField("name", type: .nonNull(.scalar(String.self))),
                      GraphQLField("username", type: .nonNull(.scalar(String.self))),
                      GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                      GraphQLField("state", type: .nonNull(.scalar(UserState.self))),
                      GraphQLField("webUrl", type: .nonNull(.scalar(String.self))),
                    ]
                  }

                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public init(avatarUrl: String? = nil, name: String, username: String, id: GraphQLID, state: UserState, webUrl: String) {
                    self.init(unsafeResultMap: ["__typename": "UserCore", "avatarUrl": avatarUrl, "name": name, "username": username, "id": id, "state": state, "webUrl": webUrl])
                  }

                  public var __typename: String {
                    get {
                      return resultMap["__typename"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "__typename")
                    }
                  }

                  /// URL of the user's avatar.
                  public var avatarUrl: String? {
                    get {
                      return resultMap["avatarUrl"] as? String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "avatarUrl")
                    }
                  }

                  /// Human-readable name of the user.
                  public var name: String {
                    get {
                      return resultMap["name"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "name")
                    }
                  }

                  /// Username of the user. Unique within this instance of GitLab.
                  public var username: String {
                    get {
                      return resultMap["username"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "username")
                    }
                  }

                  /// ID of the user.
                  public var id: GraphQLID {
                    get {
                      return resultMap["id"]! as! GraphQLID
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "id")
                    }
                  }

                  /// State of the user.
                  public var state: UserState {
                    get {
                      return resultMap["state"]! as! UserState
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "state")
                    }
                  }

                  /// Web URL of the user.
                  public var webUrl: String {
                    get {
                      return resultMap["webUrl"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "webUrl")
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}
