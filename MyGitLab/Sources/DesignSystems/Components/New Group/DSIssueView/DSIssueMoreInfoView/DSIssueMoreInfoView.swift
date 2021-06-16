//
//  DSIssueMoreInfoView.swift
//  MyGitLab
//
//  Created by PHAM ANH TUAN on 12/06/2021.
//

import UIKit
import Reusable
import Kingfisher

class DSIssueMoreInfoView: UIView, NibOwnerLoadable {
    
    @IBOutlet private weak var authorAvatarImageView: UIImageView!
    @IBOutlet private weak var authorAvatarWrapView: UIView!
    @IBOutlet private weak var authorUsernameLabel: UILabel!
    
    @IBOutlet private weak var upVotesActionLabel: DSActionLabel!
    @IBOutlet private weak var upVotesWrapView: UIView!
    
    @IBOutlet private weak var downVotesWrapView: UIView!
    @IBOutlet private weak var downVotesActionLabel: DSActionLabel!
    
    @IBOutlet private weak var commentsWrapView: UIView!
    @IBOutlet private weak var commentsActionLabel: DSActionLabel!
    
    private var viewMode: ViewMode = .preView {
        didSet {
            updateViewMode()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupViews()
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        authorAvatarWrapView.layer.masksToBounds = true
        authorAvatarWrapView.layer.cornerRadius = authorAvatarWrapView.bounds.height / 2
    }
    
    private func setupViews() {
        self.loadNibContent()
        
        setupAuthorView()
        setupVoteViews()
    }
    
    private func setupAuthorView() {
        
        authorUsernameLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        authorUsernameLabel.textColor = Colors.ink400
        
        layoutIfNeeded()
    }
    
    private func setupVoteViews() {
        upVotesActionLabel.setActionImage(.local(assetName: Asset.Icon.Common.EmotionAction.icLike128.name))
        downVotesActionLabel.setActionImage(.local(assetName: Asset.Icon.Common.EmotionAction.icDislike128.name))
        commentsActionLabel.setActionImage(.local(assetName: Asset.Icon.Common.EmotionAction.icComments128.name))
    }
    
    private func updateViewMode() {
        switch viewMode {
        case .preView:
            upVotesWrapView.isHidden = false
            downVotesWrapView.isHidden = false
            commentsWrapView.isHidden = false
            
        case .detail:
            upVotesWrapView.isHidden = false
            downVotesWrapView.isHidden = false
            commentsWrapView.isHidden = true
        }
    }
}

extension DSIssueMoreInfoView {
    
    @discardableResult
    func setAuthor(avatarUrl: URL?, userName: String) -> DSIssueMoreInfoView {
        authorUsernameLabel.text = userName
        authorAvatarImageView.kf.setImage(
            with: avatarUrl,
            placeholder: nil,
            options: [.transition(.fade(0.25))],
            completionHandler: nil
        )
        
        return self
    }
    
    @discardableResult
    func setViewMode(_ mode: ViewMode) -> DSIssueMoreInfoView {
        self.viewMode = mode
        return self
    }
    
    @discardableResult
    func setTotalUpVotes(_ total: Int) -> DSIssueMoreInfoView {
        upVotesActionLabel.setActionTitle("\(total)")
        return self
    }
    
    @discardableResult
    func setTotalDownVotes(_ total: Int) -> DSIssueMoreInfoView {
        downVotesActionLabel.setActionTitle("\(total)")
        return self
    }
    
    @discardableResult
    func setTotalComments(_ total: Int) -> DSIssueMoreInfoView {
        commentsActionLabel.setActionTitle("\(total)")
        return self
    }
}

extension DSIssueMoreInfoView {
    enum ViewMode {
        case preView
        case detail
    }
}
