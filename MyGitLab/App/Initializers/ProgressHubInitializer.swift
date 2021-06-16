//
//  ProgressHubInitializer.swift
//  MyGitLab
//
//  Created by PHAM ANH TUAN on 15/06/2021.
//

import Foundation
import ProgressHUD

class ProgressHUBInitializer: Initializable {
    func performInitialization() {
        ProgressHUD.animationType = .circleSpinFade
        ProgressHUD.colorProgress = .systemRed
        ProgressHUD.colorBackground = .clear
    }
}
