//
//  DSIssueTableViewCell.swift
//  MyGitLab
//
//  Created by PHAM ANH TUAN on 12/06/2021.
//

import UIKit
import Reusable

class DSIssueTableViewCell: UITableViewCell, NibReusable {
    
    @IBOutlet private weak var mainContainerView: UIView!
    @IBOutlet private weak var gitlabIssueView: DSIssueView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    private func setupView() {
        gitlabIssueView.layer.masksToBounds = true
        gitlabIssueView.layer.cornerRadius = 8.0
        
        gitlabIssueView.layer.borderWidth = 0.1
        gitlabIssueView.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        
        mainContainerView.setShadowStyle(.shadow8)
        gitlabIssueView.setStyle(.preview)
    }
    
    func configureCell(viewModel: DSIssueViewModel) {
        gitlabIssueView.configureView(viewModel: viewModel)
    }
    
}
