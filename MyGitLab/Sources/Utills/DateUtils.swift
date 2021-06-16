//
//  DateUtils.swift
//  MyGitLab
//
//  Created by PHAM ANH TUAN on 15/06/2021.
//

import Foundation

struct DateUtils {
  static var dateFormatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    return formatter
  }
  
  static func displayDate(for date: Date) -> String {
    return dateFormatter.string(from: date)
  }
}

extension Date {
  var beforeCurrent: Double {
    let intervalInSeconds = Date().timeIntervalSince(self)
    return intervalInSeconds
  }
}

extension Double {
  func asString(style: DateComponentsFormatter.UnitsStyle) -> String {
    let formatter = DateComponentsFormatter()
    formatter.allowedUnits = [.year, .month, .hour, .minute, .second, .nanosecond]
    formatter.unitsStyle = style
    guard let formattedString = formatter.string(from: self) else { return "" }
    return formattedString
  }
}

