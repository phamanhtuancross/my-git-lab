//
//  Natrium.swift
//  MyGitLab
//
//  Created by PHAM ANH TUAN on 11/06/2021.
//

import Foundation

enum AppEnvironment: String {
    case dev
    case staging
    case uat
    case production
    
    static var current: AppEnvironment {
        return .staging
    }
}

protocol NatriumMappable {
    var environmentParraments: [AppEnvironment: String] { get }
}

extension NatriumMappable {
    var currentValue: String {
        return (environmentParraments[AppEnvironment.current]).or((environmentParraments.values.first).or(""))
    }
}

enum GitlabGraphQLAPIBase: NatriumMappable {
    case `current`
    
    var environmentParraments: [AppEnvironment : String] {
        return [
            .dev: "https://gitlab.com/api/graphql"
        ]
    }
}

enum GitLabAPIBase: NatriumMappable {
    case `current`
    
    var environmentParraments: [AppEnvironment : String] {
        return [.dev : "https://gitlab.com"]
    }
}

enum AppStorageSQLiteFileName: NatriumMappable {
    case `current`
    
    var environmentParraments: [AppEnvironment : String] {
        return [ .dev: "my_gitlab.sqlite"]
    }
}

enum Natrium {
    static let gitLabGraphQLAPIBase: String = GitlabGraphQLAPIBase.current.currentValue
    static let gitlabAPIBase: String = GitLabAPIBase.current.currentValue
    static let appStorageSQLiteFileName: String = AppStorageSQLiteFileName.current.currentValue
}
