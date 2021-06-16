//
//  ThemeInitializer.swift
//  MyGitLab
//
//  Created by PHAM ANH TUAN on 11/06/2021.
//

import UIKit

class ThemeInitializer: Initializable {
    func performInitialization() {
        UINavigationBar.appearance(whenContainedInInstancesOf: [MGLNavigationController.self]).tintColor = SettingService.shared.currentAppTheme.barTintColor
        UINavigationBar.appearance(whenContainedInInstancesOf: [MGLNavigationController.self]).barTintColor = SettingService.shared.currentAppTheme.navigationTintColor
        UINavigationBar.appearance(whenContainedInInstancesOf: [MGLNavigationController.self]).titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
    }
}
