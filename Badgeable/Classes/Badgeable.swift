//
//  Badgeable.swift
//
//  Created by Daniel KIM on 6/10/16.
//  Copyright © 2016 Gwangpa dot com. All rights reserved.
//

// TODO: Make it adjustable position. Eg: TopRight, TopLeft, BottomRight, BottomLeft.
// TODO: Provide animation effects.
// TODO: Make badge appearance customizable.

import ObjectiveC
import UIKit

private struct BadgableAssociatedKeys {
    static var badgeCount = "badgableBadgeCount"
    static var maxValue = "badgableBadgeMaxValue"
    static var badgeColor = "badgableBadgeColor"
    static var badgePosition = "badgableBadgePosition"
    static var badgeLabel = "badgeLabel"
}

public enum BadgePosition {
    case topRight
    case topLeft
    case bottomRight
    case bottomLeft
}

public protocol Badgeable {
    
    var badgeCount: Int { get set }
    var badgeColor: UIColor { get set }
    var maxValue: Int { get set }
    var badgePosition: BadgePosition { get set }
    
}

public extension Badgeable {
    /// Badge count. Can display badge by setting this variable.
    var badgeCount: Int {
        get {
            return objc_getAssociatedObject(self, &BadgableAssociatedKeys.badgeCount) as? Int ?? 0
        }
        set {
            objc_setAssociatedObject(self, &BadgableAssociatedKeys.badgeCount, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            presentBadge()
        }
    }
    /// Max value. If badgeCount(120) is greater than max (99), will show: 99+
    var maxValue: Int {
        get {
            return objc_getAssociatedObject(self, &BadgableAssociatedKeys.maxValue) as? Int ?? badgeCount
        }
        set {
            objc_setAssociatedObject(self, &BadgableAssociatedKeys.maxValue, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            presentBadge()
        }
    }
    /// Badge color. Can change background color - Default is .red
    var badgeColor: UIColor {
        get {
            return objc_getAssociatedObject(self, &BadgableAssociatedKeys.badgeColor) as? UIColor ?? .red
        }
        set {
            objc_setAssociatedObject(self, &BadgableAssociatedKeys.badgeColor, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            presentBadge()
        }
    }
    /// Badge position. TopRight, TopLeft, BottomRight, BottomLeft - Default is .topRight
    var badgePosition: BadgePosition {
        get {
            return objc_getAssociatedObject(self, &BadgableAssociatedKeys.badgePosition) as? BadgePosition ?? .topRight
        }
        set {
            objc_setAssociatedObject(self, &BadgableAssociatedKeys.badgePosition, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            presentBadge()
        }
    }
    
    
    /// Computed badgeLabel.
    /// If it's nil it will create one.
    private var badgeLabel: UILabel {
        mutating get {
            guard let badgeLabel = objc_getAssociatedObject(self, &BadgableAssociatedKeys.badgeLabel) as? UILabel else {
                let badgeLabel = labelForBadge()
                self.badgeLabel = badgeLabel
                return badgeLabel
            }
            return badgeLabel
        }
        set {
            objc_setAssociatedObject(self, &BadgableAssociatedKeys.badgeLabel, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    /// Display badge label into super view.
    /// It supports subclass of UIView and UIBarButtonItem only.
    /// If badge being displayed in UIBarButtonItem then it uses customView for superview.
    /// Badgable will work only if UIBarButtonItem uses customView.
    private mutating func presentBadge() {
        // Configure badge label
        if badgeCount > maxValue {
            badgeLabel.text = "\(maxValue)+"
        } else {
            badgeLabel.text = "\(badgeCount)"
        }
        badgeLabel.sizeToFit()
        var labelFrame = badgeLabel.frame
        labelFrame.size.width += 4
        labelFrame.size.height += 4
        if labelFrame.size.width < labelFrame.size.height {
            labelFrame.size.width = labelFrame.size.height
        }
        badgeLabel.frame = labelFrame
        badgeLabel.layer.cornerRadius = labelFrame.size.height / 2.0
        badgeLabel.isHidden = badgeCount == 0
        badgeLabel.backgroundColor = badgeColor
        
        // Add to super view, adjust frame
        if let barButtonItem = self as? UIBarButtonItem {
            if let customView = barButtonItem.customView {
                badgeLabel.frame = positionedFrame(badgeLabel: badgeLabel, to: customView, position: badgePosition)
                customView.clipsToBounds = false
                customView.addSubview(badgeLabel)
            }
        } else if let view = self as? UIView {
            badgeLabel.frame = positionedFrame(badgeLabel: badgeLabel, to: view, position: badgePosition)
            view.clipsToBounds = false
            view.addSubview(badgeLabel)
        }
    }
    
    /// Calculate frame badgelabel sit top right side of super view.
    /// Returns calculated CGRect.
    private func positionedFrame(badgeLabel: UILabel, to superView: UIView, position: BadgePosition) -> CGRect {
        var frame = badgeLabel.frame
     
        let right = superView.frame.size.width - frame.size.width / 2.0
        let left = -frame.size.width / 2.0
        let bottom = superView.frame.size.height - frame.size.height / 2.0
        let top = -frame.size.height / 2.0
        
        switch position {
        case .topRight:
            frame.origin.x = right
            frame.origin.y = top
        case .topLeft:
            frame.origin.x = left
            frame.origin.y = top
        case .bottomRight:
            frame.origin.x = right
            frame.origin.y = bottom
        case .bottomLeft:
            frame.origin.x = left
            frame.origin.y = bottom
        }
        
        return frame
    }
    
    /// Instantiate UILabel for badge.
    private func labelForBadge() -> UILabel {
        let label = UILabel()
        label.clipsToBounds = true
        label.font = UIFont.systemFont(ofSize: 10.0)
        label.backgroundColor = UIColor.red
        label.textColor = UIColor.white
        label.textAlignment = .center
        return label
    }
    
}
