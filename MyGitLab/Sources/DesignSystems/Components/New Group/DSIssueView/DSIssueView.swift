//
//  DSIssueView.swift
//  MyGitLab
//
//  Created by PHAM ANH TUAN on 12/06/2021.
//
import UIKit
import Reusable
import Differentiator

struct DSIssueViewModel {
    
    let model: MGLIssue
    
    init(model: MGLIssue) {
        self.model = model
    }
}

extension DSIssueViewModel {
    
    var id: String {
        return model.id
    }
    
    var stateTitle: String {
        return model.state.rawValue.uppercased()
    }
    
    var issueTitle: String {
        return model.title
    }
    
    var stateStyle: DSStatusView.Style {
        switch model.state {
        case .opened:
            return .green
        case .merged:
            return .primary
        default:
            return .gray
        }
    }
    
    var authorAvatarURL: URL? {
        
        guard let url = model.author?.avatarUrl else { return nil }
        guard url.starts(with: "/uploads") else { return URL(string: url) }
        return URL(string: Natrium.gitlabAPIBase + url)
    }
    
    var authorUsername: String {
        return (model.author?.username).or("")
    }
    
    var upVotes: Int {
        return model.upVotes
    }
    
    var downVotes: Int {
        return model.downVotes
    }
    
    var totalComments: Int {
        return model.userNotesCount
    }
    
    var timeOpened: String {
        let dateFormatter = ISO8601DateFormatter()
        guard let createdDate = model.milestone?.createAt else { return ""}
        guard let date = dateFormatter.date(from: createdDate) else { return "" }
        return "Opened \(date.beforeCurrent.asString(style: .short)) ago"
    }
}

extension DSIssueViewModel: Codable {
    private enum CodingKeys: String, CodingKey {
        case model
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        model = (try? container.decode(MGLIssue.self, forKey: .model)).or(.default)
    }
    
}

extension DSIssueViewModel: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.identity == rhs.identity
    }
}

extension DSIssueViewModel: IdentifiableType {
    var identity: String {
        return id
    }
}

class DSIssueView: UIView, NibOwnerLoadable {
    
    @IBOutlet private weak var stateStatusView: DSStatusView!
    @IBOutlet private weak var issueTitleLabel: UILabel!
    @IBOutlet private weak var shortcutIssueInfoView: DSIssueInfoView!
    @IBOutlet private weak var issueMoreInfoVIew: DSIssueMoreInfoView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupViews()
    }
    
    private func setupViews() {
        self.loadNibContent()
        setupHeaderViews()
    }
    
    private func setupHeaderViews() {
        issueTitleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        issueTitleLabel.textColor = UIColor.black
    }
    
    func configureView(viewModel: DSIssueViewModel) {
        
        stateStatusView.setStyle(viewModel.stateStyle)
        stateStatusView.setStatusTitle(viewModel.stateTitle)
        
        issueTitleLabel.text = viewModel.issueTitle
        
        issueMoreInfoVIew.setAuthor(avatarUrl: viewModel.authorAvatarURL, userName: viewModel.authorUsername)
        
        issueMoreInfoVIew.setTotalUpVotes(viewModel.upVotes)
        issueMoreInfoVIew.setTotalDownVotes(viewModel.downVotes)
        issueMoreInfoVIew.setTotalComments(viewModel.totalComments)
        
        shortcutIssueInfoView.setTitlte("gitlab/show-case/microservice/graphql")
        shortcutIssueInfoView.setDescription(viewModel.timeOpened)
    }
}

extension DSIssueView {
    
    enum Style {
        case preview
        case detail
    }
    
    @discardableResult
    func setStyle(_ style: Style) -> DSIssueView {
        switch style {
        case .preview:
            issueMoreInfoVIew.setViewMode(.preView)
            
        case .detail:
            issueMoreInfoVIew.setViewMode(.detail)
        }
        
        return self
    }
}
