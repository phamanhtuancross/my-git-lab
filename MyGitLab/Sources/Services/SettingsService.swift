//
//  SettingsService.swift
//  MyGitLab
//
//  Created by PHAM ANH TUAN on 11/06/2021.
//

import UIKit

/// Setting Service Local Caching Data
extension UserDefaults {
    private enum Keys: String {
        case appThemeType
    }
    
    var currentAppTheme: AppThemeType {
        get {
            return (AppThemeType(rawValue: integer(forKey: Keys.appThemeType.rawValue))).or(.light)
        }
        set {
            setValue(newValue.rawValue, forKey: Keys.appThemeType.rawValue)
        }
    }
}

enum AppThemeType: Int {
    case light = 0
    case dark = 1
    
    var barTintColor: UIColor {
        switch self {
        case .dark:
            return UIColor.white
            
        case .light:
            return UIColor.white
        }
    }
    
    var navigationTintColor: UIColor {
        switch self {
        case .dark:
            return .black
            
        case .light:
            return UIColor.orange
        }
    }
}

public class SettingService {
    public static var shared = SettingService()
    
    private init() {}
    
    var currentAppTheme: AppThemeType {
        get {
            return UserDefaults.standard.currentAppTheme
        }
        
        set {
            UserDefaults.standard.currentAppTheme = newValue
        }
    }
}
