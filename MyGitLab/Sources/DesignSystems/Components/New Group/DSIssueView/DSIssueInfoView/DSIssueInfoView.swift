//
//  DSIssueInfoView.swift
//  MyGitLab
//
//  Created by PHAM ANH TUAN on 12/06/2021.
//

import UIKit
import Reusable

class DSIssueInfoView: UIView, NibOwnerLoadable {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
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
        
        [
            titleLabel,
            descriptionLabel
        ]
        .forEach {
            $0?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
            $0?.textColor = Colors.ink400
        }
    }
}

extension DSIssueInfoView {
    
    @discardableResult
    func setTitlte(_ title: String, highlights: [String] = []) -> DSIssueInfoView {
        titleLabel.text = title
        return self
    }
    
    @discardableResult
    func setDescription(_ infoDescription: String, highlights: [String] = []) -> DSIssueInfoView {
        descriptionLabel.text = infoDescription
        return self
    }
}
