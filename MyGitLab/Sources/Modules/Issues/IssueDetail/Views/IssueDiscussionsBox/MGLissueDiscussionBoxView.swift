//
//  MGLissueDiscussionBoxView.swift
//  MyGitLab
//
//  Created by PHAM ANH TUAN on 14/06/2021.
//

import UIKit
import Reusable

class MGLissueDiscussionBoxView: UIView, NibOwnerLoadable {
    
    @IBOutlet private weak var releaseLabel: UILabel!
    @IBOutlet private weak var textBoxContainerView: UIView!
    @IBOutlet private weak var releaseChatBoxContainerView: UIView!
    @IBOutlet private weak var chatBoxTextField: UITextField!
    
    var didChangeKeyboardHeight: ((CGFloat) -> Void)?
    var didSubmitDiscussMessage: ((String) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupViews()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func setupViews() {
        loadNibContent()
        
        releaseLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        releaseLabel.textColor = .orange
        
        textBoxContainerView.layer.masksToBounds = true
        textBoxContainerView.layer.cornerRadius = 8.0
        
        chatBoxTextField.delegate = self
        registerNotifications()
        
        setupSubmitDiscussionBox()
    }
    
    private func setupSubmitDiscussionBox() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didSubmitDiscussion))
        releaseChatBoxContainerView.addGestureRecognizer(tapGesture)
    }
    
    @objc
    private func didSubmitDiscussion() {
        let discussionMessage = chatBoxTextField.text.or("")
        didSubmitDiscussMessage?(discussionMessage)
        chatBoxTextField.resignFirstResponder()
    }
    
    private func hideKeyBoard() {
        chatBoxTextField.resignFirstResponder()
    }
    
    private func registerNotifications() {
        NotificationCenter
            .default
            .addObserver(
                self,
                selector: #selector(keyboardWillChange(notification:)),
                name: UIResponder.keyboardWillShowNotification,
                object: nil
            )
        
        NotificationCenter
            .default
            .addObserver(
                self,
                selector: #selector(keyboardWillChange(notification:)),
                name: UIResponder.keyboardWillHideNotification,
                object: nil
            )
        
        NotificationCenter
            .default
            .addObserver(
                self,
                selector: #selector(keyboardWillChange(notification:)),
                name: UIResponder.keyboardWillChangeFrameNotification,
                object: nil
            )
    }
    
    @objc
    private func keyboardWillChange(notification: Notification) {
        print("Keyboard will change: \(notification.name)")
        
        switch notification.name {
        case UIResponder.keyboardWillChangeFrameNotification:
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                let keyboardHeight = keyboardSize.height
                didChangeKeyboardHeight?(keyboardHeight)
            }
        case UIResponder.keyboardWillShowNotification:
            break
            
        case UIResponder.keyboardWillHideNotification:
            didChangeKeyboardHeight?(.zero)
            
        default:
            break
        }
    }
}

extension MGLissueDiscussionBoxView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        chatBoxTextField.resignFirstResponder()
        return true
    }
}
