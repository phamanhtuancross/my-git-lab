//
//  DSShadowStyles.swift
//  MaiNgaBeatyMembershipManagement
//
//  Created by PHAM ANH TUAN on 2/9/21.
//

import UIKit

public enum DSShadowStyle {
    case none, shadow4, shadow8, shadow4Revert
}

public enum Colors { }
public extension Colors {
    static let ink100 = #colorLiteral(red: 0.003921569, green: 0.07058824, blue: 0.13333334, alpha: 0.050980393)
    /// 0xf2f3f4ff (r: 242, g: 243, b: 244, a: 255)
    static let ink100s = #colorLiteral(red: 0.9490196, green: 0.9529412, blue: 0.95686275, alpha: 1.0)
    /// 0x0112221a (r: 1, g: 18, b: 34, a: 26)
    static let ink200 = #colorLiteral(red: 0.003921569, green: 0.07058824, blue: 0.13333334, alpha: 0.101960786)
    /// 0xe6e7e9ff (r: 230, g: 231, b: 233, a: 255)
    static let ink200s = #colorLiteral(red: 0.9019608, green: 0.90588236, blue: 0.9137255, alpha: 1.0)
    /// 0x0112224d (r: 1, g: 18, b: 34, a: 77)
    static let ink300 = #colorLiteral(red: 0.003921569, green: 0.07058824, blue: 0.13333334, alpha: 0.3019608)
    /// 0xb3b8bdff (r: 179, g: 184, b: 189, a: 255)
    static let ink300s = #colorLiteral(red: 0.7019608, green: 0.72156864, blue: 0.7411765, alpha: 1.0)
    /// 0x01122280 (r: 1, g: 18, b: 34, a: 128)
    static let ink400 = #colorLiteral(red: 0.003921569, green: 0.07058824, blue: 0.13333334, alpha: 0.5019608)
    /// 0x808890ff (r: 128, g: 136, b: 144, a: 255)
    static let ink400s = #colorLiteral(red: 0.5019608, green: 0.53333336, blue: 0.5647059, alpha: 1.0)
    /// 0x22313fff (r: 34, g: 49, b: 63, a: 255)
    static let ink500 = #colorLiteral(red: 0.13333334, green: 0.19215687, blue: 0.24705882, alpha: 1.0)
}

extension DSShadowStyle {

    var style: ShadowStyle {
        switch self {
        case .none: return Shadow.None()
        case .shadow4: return Shadow.Shadow4()
        case .shadow8: return Shadow.Shadow8()
        case .shadow4Revert: return Shadow.Shadow4Revert()
        }
    }
}

protocol ShadowStyle {
    var color: CGColor { get }
    var offset: CGSize { get }
    var opacity: Float { get }
    var radius: CGFloat { get }
}

enum Shadow {

    struct None: ShadowStyle {
        let color: CGColor = UIColor.clear.cgColor
        let offset: CGSize = .zero
        let opacity: Float = 0.0
        let radius: CGFloat = 0.0
    }

    struct Shadow4: ShadowStyle {
        let color: CGColor = Colors.ink200.cgColor
        let offset: CGSize = CGSize(width: 0.0, height: 2.0)
        let opacity: Float = 1.0
        let radius: CGFloat = 4.0
    }

    struct Shadow8: ShadowStyle {
        let color: CGColor = Colors.ink200.cgColor
        let offset: CGSize = CGSize(width: 0.0, height: 4.0)
        let opacity: Float = 1.0
        let radius: CGFloat = 8.0
    }

    struct Shadow4Revert: ShadowStyle {
        let color: CGColor = Colors.ink200.cgColor
        let offset: CGSize = CGSize(width: 0.0, height: -2.0)
        let opacity: Float = 1.0
        let radius: CGFloat = 4.0
    }
}

// Legacy code

public protocol DS2ShadowStyles {
    var shadowOffset: CGSize { get }
    var shadowRadius: CGFloat { get }
    var shadowColor: UIColor { get }
    var shadowOpacity: Float { get }
}

public struct DS2ShadowStyle1: DS2ShadowStyles {
    public let shadowOffset: CGSize = CGSize(width: 0, height: 2)
    public var shadowRadius: CGFloat = 8.0
    public var shadowColor: UIColor = UIColor.black
    public var shadowOpacity: Float = 0.1
    public init() {}
}

public struct DS2ShadowStyle2: DS2ShadowStyles {
    public let shadowOffset: CGSize = CGSize(width: 0, height: 4)
    public var shadowRadius: CGFloat = 12.0
    public var shadowColor: UIColor = UIColor.black
    public var shadowOpacity: Float = 0.1
    public init() {}
}

public struct DS2ShadowStyle3: DS2ShadowStyles {
    public let shadowOffset: CGSize = CGSize(width: 0, height: -8)
    public var shadowRadius: CGFloat = 8.0
    public var shadowColor: UIColor = UIColor.black
    public var shadowOpacity: Float = 0.06
    public init() {}
}

extension UIView {

    @available(*, deprecated, message: "Use `setShadowStyle(_ shadowStyle: DSShadowStyle)` instead")
    public func apply(ds2ShadowStyle shadowStyle: DS2ShadowStyles) {
        layer.shadowColor = shadowStyle.shadowColor.cgColor
        layer.shadowOffset = shadowStyle.shadowOffset
        layer.shadowRadius = shadowStyle.shadowRadius
        layer.shadowOpacity = shadowStyle.shadowOpacity
    }

    public func roundCorners(_ corners: UIRectCorner, cornerRadius: Double) {
        let path = UIBezierPath(roundedRect: self.bounds,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
    }

    public func setShadowStyle(_ shadowStyle: DSShadowStyle, path: UIBezierPath? = nil) {
        let style = shadowStyle.style
        layer.shadowColor = style.color
        if let path = path {
            layer.shadowPath = path.cgPath
        }
        layer.shadowOffset = style.offset
        layer.shadowOpacity = style.opacity
        layer.shadowRadius = style.radius / UIScreen.main.scale // ratio to matching design
    }
}
