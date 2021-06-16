//
//  MGLDiscussionHeaderView.swift
//  MyGitLab
//
//  Created by PHAM ANH TUAN on 13/06/2021.
//

import UIKit
import Reusable

class MGLDiscussionHeaderView: UITableViewHeaderFooterView, NibReusable {
    
    @IBOutlet private weak var headerTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    private func setupViews() {
        headerTitleLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        headerTitleLabel.text = "Comments:--"
    }
}
