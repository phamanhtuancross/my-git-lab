//
//  MGLDiscussionCell.swift
//  MyGitLab
//
//  Created by PHAM ANH TUAN on 13/06/2021.
//

import UIKit
import Reusable
import Differentiator
import Kingfisher

struct MGLDiscussionViewModel {
    var id: String {
        return model.id
    }
    
    var username: String {
        return (model.notes.nodes.first?.author.username).or("")
    }
    
    var timeCreate: String {
        return model.createdAt
    }
    
    var bodyHtml: String {
        return (model.notes.nodes.first?.bodyHtml).or("")
    }
    
    var userAvatarURL: URL? {
        
        guard let urlString = model.notes.nodes.first?.author.avatarUrl else { return nil }
        guard urlString.starts(with: "/uploads") else {
            return URL(string: urlString)
        }
        
        return URL(string: Natrium.gitlabAPIBase + urlString)
    }
    
    let model: MGLIssueDiscussion
}

extension MGLDiscussionViewModel: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.identity == rhs.identity
    }
}

extension MGLDiscussionViewModel: IdentifiableType {
    var identity: String {
        return id
    }
}


class MGLDiscussionCell: UITableViewCell, NibReusable {

    @IBOutlet private weak var userAvatarImageView: UIImageView!
    @IBOutlet private weak var userAvatarWrapView: UIView!
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var createAtLabel: UILabel!
    @IBOutlet private weak var discussionBodyTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        userAvatarWrapView.layer.masksToBounds = true
        userAvatarWrapView.layer.cornerRadius = userAvatarWrapView.bounds.height / 2
    }
    
    private func setupViews() {
        userNameLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        userNameLabel.textColor = Colors.ink400
        
        createAtLabel.font = UIFont.systemFont(ofSize: 12, weight: .light)
        createAtLabel.textColor = Colors.ink400s
        
        discussionBodyTextView.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        discussionBodyTextView.textColor = Colors.ink500
        
    }
    
    func configureCell(viewModel: MGLDiscussionViewModel) {
        userNameLabel.text = viewModel.username
        createAtLabel.text = viewModel.timeCreate
        discussionBodyTextView.text = viewModel.bodyHtml.htmlToString
        userAvatarImageView.kf.setImage(with: viewModel.userAvatarURL, options: [.transition(.fade(0.25))])
    }
}

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}
