//
//  DSActionLabel.swift
//  MyGitLab
//
//  Created by PHAM ANH TUAN on 12/06/2021.
//

import UIKit
import Reusable

enum DSImageAssetType {
    case url(String)
    case local(assetName: String)
}

class DSActionLabel: UIView, NibOwnerLoadable {
    
    @IBOutlet private weak var leftIconImageView: UIImageView!
    @IBOutlet private weak var actionTitleLabel: UILabel!
    
    private var style: Style = .small {
        didSet {
            updateStyle()
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
    
    private func setupViews() {
        self.loadNibContent()
        setupTitleLabel()
        
        style = .small
    }
    
    private func setupTitleLabel() {
        actionTitleLabel.textColor = Colors.ink400
    }
    
    private func updateStyle() {
        actionTitleLabel.font = style.font
    }
}

extension DSActionLabel {
    struct Style {
        let font: UIFont
        
        static let small: Style = .init(font: UIFont.systemFont(ofSize: 14, weight: .light))
        
        static let medium: Style = .init(font: UIFont.systemFont(ofSize: 18, weight: .medium))
    }
}

extension DSActionLabel {
    
    @discardableResult
    func setStyle(_ style: Style) -> DSActionLabel {
        self.style = style
        return self
    }
    
    @discardableResult
    func setActionTitle(_ title: String) -> DSActionLabel {
        actionTitleLabel.text = title
        return self
    }
    
    @discardableResult
    func setActionImage(_ image: DSImageAssetType) -> DSActionLabel {
        switch image {
        case .local(let assetName):
            leftIconImageView.image = UIImage(named: assetName)
            leftIconImageView.tintColor = Colors.ink400
            
        case .url(let url):
            leftIconImageView.kf.setImage(with: URL(string: url), options: [.transition(.fade(0.25))])
        }
        
        return self
    }
}
