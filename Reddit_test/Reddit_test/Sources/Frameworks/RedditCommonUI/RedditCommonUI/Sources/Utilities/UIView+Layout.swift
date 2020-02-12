//
//  UIView+Layout.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 12.02.2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit

public enum LayoutConstraintType {
    case top
    case bottom
    case left
    case right
    case centerX
    case centerY
}

public typealias LayoutConstraints = [LayoutConstraintType: NSLayoutConstraint]

public extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        if #available(iOS 11.0, *) {
            clipsToBounds = false
            layer.cornerRadius = radius
            var cornerMask: CACornerMask = []
            if corners.contains(.topLeft) {
                cornerMask.insert(.layerMinXMinYCorner)
            }
            if corners.contains(.topRight) {
                cornerMask.insert(.layerMaxXMinYCorner)
            }
            if corners.contains(.bottomLeft) {
                cornerMask.insert(.layerMinXMaxYCorner)
            }
            if corners.contains(.bottomRight) {
                cornerMask.insert(.layerMaxXMaxYCorner)
            }
            layer.maskedCorners = cornerMask
        } else {
            let rectShape = CAShapeLayer()
            rectShape.bounds = frame
            rectShape.position = center
            rectShape.path = UIBezierPath(roundedRect: bounds,
                                          byRoundingCorners: corners,
                                          cornerRadii: CGSize(width: radius, height: radius)).cgPath
            layer.mask = rectShape
        }
    }
    
    @discardableResult
    func fillSuperview(_ edgeInsets: UIEdgeInsets = .zero) -> LayoutConstraints {
        var constraints = fillVerticallySuperview(edgeInsets.top, edgeInsets.bottom)
        let horizontalConstraints = fillHorizontallySuperview(edgeInsets.left, edgeInsets.right)
        for (key, value) in horizontalConstraints {
            constraints[key] = value
        }
        return constraints
    }

    @discardableResult
    func fillVerticallySuperview(_ topOffset: CGFloat = 0,
                                 _ bottomOffset: CGFloat = 0) -> LayoutConstraints {
        [
            .top: topToSuperView(offset: topOffset),
            .bottom: bottomToSuperView(offset: bottomOffset)
        ]
    }

    @discardableResult
    func fillHorizontallySuperview(_ leftOffset: CGFloat = 0,
                                   _ rightOffset: CGFloat = 0) -> LayoutConstraints {
        [
            .left: leftToSuperView(offset: leftOffset),
            .right: rightToSuperView(offset: rightOffset)
        ]
    }

    @discardableResult
    func height(_ height: CGFloat) -> NSLayoutConstraint {
        addConstraint(attribute: .height,
                      toView: nil,
                      viewToAddConstraint: nil,
                      toViewAttribute: .height,
                      offset: height)
    }

    @discardableResult
    func width(_ width: CGFloat) -> NSLayoutConstraint {
        addConstraint(attribute: .width,
                      toView: nil,
                      viewToAddConstraint: nil,
                      toViewAttribute: .width,
                      offset: width)
    }
    
    @discardableResult
    func aspect(_ aspect: CGFloat) -> NSLayoutConstraint {
        addConstraint(attribute: .height,
                      toView: nil,
                      viewToAddConstraint: nil,
                      toViewAttribute: .width,
                      offset: 0.0,
                      multiplier: aspect)
    }

    @discardableResult
    func centerInSuperview(_ offset: CGFloat = 0) -> LayoutConstraints {
        center(superview, offset)
    }

    @discardableResult
    func center(_ toView: UIView?, _ offset: CGFloat = 0) -> LayoutConstraints {
        [
            .centerY: centerY(toView: toView, offset),
            .centerX: centerX(toView: toView, offset)
        ]
    }

    @discardableResult
    func centerYInSuperview(_ offset: CGFloat = 0) -> NSLayoutConstraint {
        centerY(toView: superview, offset)
    }

    @discardableResult
    func centerY(toView: UIView?, _ offset: CGFloat = 0) -> NSLayoutConstraint {
        addConstraint(attribute: .centerY,
                      toView: toView,
                      viewToAddConstraint: superview,
                      toViewAttribute: .centerY,
                      offset: offset)
    }

    @discardableResult
    func centerXInSuperview(_ offset: CGFloat = 0) -> NSLayoutConstraint {
        centerX(toView: superview, offset)
    }

    @discardableResult
    func centerX(toView: UIView?, _ offset: CGFloat = 0) -> NSLayoutConstraint {
        addConstraint(attribute: .centerX,
                      toView: toView,
                      viewToAddConstraint: superview,
                      toViewAttribute: .centerX,
                      offset: offset)
    }

    @discardableResult
    func leftToRight(view: UIView,
                     offset: CGFloat = 0,
                     relation: NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint {
        addConstraint(attribute: .left,
                      toView: view,
                      viewToAddConstraint: superview,
                      toViewAttribute: .right,
                      offset: offset,
                      relation: relation)
    }

    @discardableResult
    func leftToSuperView(offset: CGFloat = 0,
                         relation: NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint {
        left(view: superview, offset: offset, relation: relation)
    }

    @discardableResult
    func left(view: UIView?,
              offset: CGFloat = 0,
              relation: NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint {
        addConstraint(attribute: .left,
                      toView: view,
                      viewToAddConstraint: superview,
                      toViewAttribute: .left,
                      offset: offset,
                      relation: relation)
    }

    @discardableResult
    func rightToLeft(view: UIView,
                     offset: CGFloat = 0,
                     relation: NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint {
        addConstraint(attribute: .right,
                      toView: view,
                      viewToAddConstraint: superview,
                      toViewAttribute: .left,
                      offset: offset,
                      relation: relation)
    }

    @discardableResult
    func rightToSuperView(offset: CGFloat = 0,
                          relation: NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint {
        right(view: superview, offset: offset, relation: relation)
    }

    @discardableResult
    func right(view: UIView?,
               offset: CGFloat = 0,
               relation: NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint {
        addConstraint(attribute: .right,
                      toView: view,
                      viewToAddConstraint: superview,
                      toViewAttribute: .right,
                      offset: offset,
                      relation: relation)
    }

    @discardableResult
    func bottomToTop(view: UIView,
                     offset: CGFloat = 0,
                     relation: NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint {
        addConstraint(attribute: .bottom,
                      toView: view,
                      viewToAddConstraint: superview,
                      toViewAttribute: .top,
                      offset: offset,
                      relation: relation)
    }

    @discardableResult
    func bottomToSuperView(offset: CGFloat = 0,
                           relation: NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint {
        bottom(view: superview, offset: offset, relation: relation)
    }

    @discardableResult
    func bottom(view: UIView?,
                offset: CGFloat = 0,
                relation: NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint {
        addConstraint(attribute: .bottom,
                      toView: view,
                      viewToAddConstraint: superview,
                      toViewAttribute: .bottom,
                      offset: offset,
                      relation: relation)
    }

    @discardableResult
    func topToBottom(view: UIView,
                     offset: CGFloat = 0,
                     relation: NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint {
        addConstraint(attribute: .top,
                      toView: view,
                      viewToAddConstraint: superview,
                      toViewAttribute: .bottom,
                      offset: offset,
                      relation: relation)
    }

    @discardableResult
    func topToSuperView(offset: CGFloat = 0,
                        relation: NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint {
        top(view: superview, viewToAddConstraint: superview, offset: offset, relation: relation)
    }

    @discardableResult
    func top(view: UIView?,
             viewToAddConstraint: UIView?,
             offset: CGFloat = 0,
             relation: NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint {
        addConstraint(attribute: .top,
                      toView: view,
                      viewToAddConstraint: viewToAddConstraint,
                      toViewAttribute: .top,
                      offset: offset,
                      relation: relation)
    }

    @discardableResult
    private func addConstraint(attribute: NSLayoutConstraint.Attribute,
                               toView: UIView?,
                               viewToAddConstraint: UIView?,
                               toViewAttribute: NSLayoutConstraint.Attribute,
                               offset: CGFloat,
                               relation: NSLayoutConstraint.Relation = .equal,
                               multiplier: CGFloat = 1.0) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: attribute,
                                            relatedBy: relation,
                                            toItem: toView,
                                            attribute: toViewAttribute,
                                            multiplier: multiplier,
                                            constant: offset)
        if let viewToAddConstraint = viewToAddConstraint {
            viewToAddConstraint.addConstraint(constraint)
        } else if let toView = toView {
            toView.addConstraint(constraint)
        } else {
            self.addConstraint(constraint)
        }

        return constraint
    }
}
