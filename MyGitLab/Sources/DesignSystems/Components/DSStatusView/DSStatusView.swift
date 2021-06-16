//
//  DSStatusView.swift
//  MyGitLab
//
//  Created by PHAM ANH TUAN on 12/06/2021.
//

import UIKit
import Reusable

class DSStatusView: UIView, NibOwnerLoadable {
    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var statusTitleLabel: UILabel!
    
    private var style: Style = .green {
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
        
        containerView.layer.masksToBounds = true
        containerView.layer.cornerRadius = 4.0
        
        statusTitleLabel.font = UIFont.boldSystemFont(ofSize: 14.0)
        
        style = .green
    }
    
    private func updateStyle() {
        statusTitleLabel.textColor = style.titleColor
        containerView.backgroundColor = style.backgroundColor
    }
}

extension DSStatusView {
    enum Style {
        case green
        case gray
        case primary
        
        var backgroundColor: UIColor {
            return  titleColor.withAlphaComponent(0.3)
        }
        
        var titleColor: UIColor {
            switch self {
            case .green:
                return #colorLiteral(red: 0.4508578777, green: 0.9882974029, blue: 0.8376303315, alpha: 1)
                
            case .primary:
                return #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
                
            case .gray:
                return #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            }
        }
    }
    
}

extension DSStatusView {
    func setStyle(_ style: Style) {
        self.style = style
    }
    
    func setStatusTitle(_ title: String) {
        statusTitleLabel.text = title
    }
}
