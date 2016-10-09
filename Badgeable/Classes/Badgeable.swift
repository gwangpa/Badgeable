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
    static var badgeCount = "dadgableBadgeCount"
    static var badgeLabel = "badgeLabel"
}

public protocol Badgeable {
    
    var badgeCount: Int { get set }
    
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
        badgeLabel.text = "\(badgeCount)"
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
        
        // Add to super view, adjust frame
        if let barButtonItem = self as? UIBarButtonItem {
            if let customView = barButtonItem.customView {
                badgeLabel.frame = positionedFrame(badgeLabel: badgeLabel, to: customView)
                customView.clipsToBounds = false
                customView.addSubview(badgeLabel)
            }
        } else if let view = self as? UIView {
            badgeLabel.frame = positionedFrame(badgeLabel: badgeLabel, to: view)
            view.clipsToBounds = false
            view.addSubview(badgeLabel)
        }
    }
    
    /// Calculate frame badgelabel sit top right side of super view.
    /// Returns calculated CGRect.
    private func positionedFrame(badgeLabel: UILabel, to superView: UIView) -> CGRect {
        var frame = badgeLabel.frame
        frame.origin.x = superView.frame.size.width - frame.size.width / 2.0
        frame.origin.y = -frame.size.height / 2.0
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
