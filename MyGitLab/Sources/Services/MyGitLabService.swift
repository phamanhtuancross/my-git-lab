//
//  MyGitLabService.swift
//  MyGitLab
//
//  Created by PHAM ANH TUAN on 12/06/2021.
//

import Foundation
import RxSwift
import Apollo
import RxOptional

protocol MyGitLabServiceType {
    func fetchIssues(of gitlabRepository: String, first: Int, after: String) -> Observable<MGLIssuePagination>
    func fetchDiscussions(of gitlabRepository: String, for issuesID: String, first: Int, after: String) -> Observable<MGLIssueDiscussionsPagination>
}

class MyGitLabService {
    
    static var `default`: MyGitLabService = MyGitLabService(apoloClient: MGLApolo.shared.client)
    
    private let client: ApolloClient
    private init(apoloClient: ApolloClient) {
        self.client = apoloClient
    }
}

extension MyGitLabService: MyGitLabServiceType {
    
    func fetchIssues(of gitlabRepository: String, first: Int, after: String) -> Observable<MGLIssuePagination> {
        return client.rx.fetch(query: IssueListQuery(gitlabRepository: gitlabRepository, first: first, after: after))
            .observe(on: MainScheduler.instance)
            .asObservable()
            .map { $0.project?.issues?.mapped() }
            .filterNil()
    }
    
    func fetchDiscussions(of gitlabRepository: String, for issuesID: String, first: Int, after: String) -> Observable<MGLIssueDiscussionsPagination> {
        return client.rx.fetch(query: DisscustionsQuery(gitlabRepository: gitlabRepository, issueID: issuesID, first: first, after: after))
            .observe(on: MainScheduler.instance)
            .asObservable()
            .map {
                $0.project?.issue?.discussions
            }
            .filterNil()
            .map { $0.mapped() }
    }
}
