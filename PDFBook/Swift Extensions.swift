//
//  Swift Extensions.swift
//  PDFBook
//
//  Created by Roselle Tanner on 3/25/17.
//  Copyright © 2017 Roselle Tanner. All rights reserved.
//

import Cocoa

extension Dictionary {

    static func withElements(_ elements: [(String, Any)]) -> Dictionary<String, Any> {
        var dictionary = [String: Any]()
        for (key, value) in elements {
            dictionary[key] = value
            dictionary.updateValue(value, forKey: key)
        }
        return dictionary
    }
}

extension NSLayoutConstraint {
    
    class func centerHorizontally(_ view: NSView) -> NSLayoutConstraint {
        let center =  NSLayoutConstraint(item: view, attribute: .centerX, relatedBy: .equal, toItem: view.superview, attribute: .centerX, multiplier: 1, constant: 0)
        center.identifier = "centerHorizontally"
        return center
    }
    
    class func centerVertically(_ view: NSView) -> NSLayoutConstraint {
        let center = NSLayoutConstraint(item: view, attribute: .centerY, relatedBy: .equal, toItem: view.superview, attribute: .centerY, multiplier: 1, constant: 0)
        center.identifier = "centerVertically"
        return center
    }
    
    class func bindTop(_ view: NSView) -> NSLayoutConstraint {
        let top =  NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: view.superview, attribute: .top, multiplier: 1.0, constant: 0)
        top.identifier = "bindTop"
        return top
    }
    
    class func bindBottom(_ view: NSView) -> NSLayoutConstraint {
        let bottom = NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: view.superview, attribute: .bottom, multiplier: 1.0, constant: 0)
        bottom.identifier = "bindBottom"
        return bottom
    }
    
    class func bindLeft(_ view: NSView) -> NSLayoutConstraint {
        let left = NSLayoutConstraint(item: view, attribute: .left, relatedBy: .equal, toItem: view.superview, attribute: .left, multiplier: 1.0, constant: 0)
        left.identifier = "bindLeft"
        return left
    }
    
    class func bindRight(_ view: NSView) -> NSLayoutConstraint {
        let right = NSLayoutConstraint(item: view, attribute: .right, relatedBy: .equal, toItem: view.superview, attribute: .right, multiplier: 1.0, constant: 0)
        right.identifier = "bindRight"
        return right
    }
    
    class func bindLeftRight(_ view: NSView) -> [NSLayoutConstraint] {
        let left = NSLayoutConstraint.bindLeft(view)
        let right = NSLayoutConstraint.bindRight(view)
        return [left, right]
    }
    class func bindTopBottom(_ view: NSView) -> [NSLayoutConstraint] {
        let top = NSLayoutConstraint.bindTop(view)
        let bottom = NSLayoutConstraint.bindBottom(view)
        return [top, bottom]
    }
    
    class func bindTopBottomLeftRight(_ view: NSView) -> [NSLayoutConstraint] {
        return bindTopBottom(view) + bindLeftRight(view)
    }
    
    class func equalRatio(_ view: NSView) -> NSLayoutConstraint {
        let ratio = NSLayoutConstraint(item: view, attribute: .width, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: .height, multiplier: 1, constant: 0)
        ratio.identifier = "equalRatio"
        return ratio
    }
    
    class func keepWidth(_ view: NSView) -> NSLayoutConstraint {
        let width = NSLayoutConstraint(item: view, attribute: .width, relatedBy: NSLayoutRelation.equal, toItem: view.superview, attribute: .width, multiplier: 1, constant: 0)
        width.identifier = "keepWidth"
        return width
    }
    
    class func keepHeight(_ view: NSView) -> NSLayoutConstraint {
        let height = NSLayoutConstraint(item: view, attribute: .height, relatedBy: NSLayoutRelation.equal, toItem: view.superview, attribute: .height, multiplier: 1, constant: 0)
        height.identifier = "keepHeight"
        return height
    }
    
    class func keepWidthAndHeight(_ view: NSView) -> [NSLayoutConstraint] {
        let width = NSLayoutConstraint.keepWidth(view)
        let height = NSLayoutConstraint.keepHeight(view)
        return [width, height]
    }
    
    class func keepHeightWithRatio(_ view: NSView, ratio: CGFloat) -> NSLayoutConstraint {
        let height = NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal, toItem: view.superview, attribute: .height, multiplier: ratio, constant: 0)
        height.identifier = "keepHeightWithRatio"
        return height
    }
    
    class func keepWidthWithRatio(_ view: NSView, ratio: CGFloat) -> NSLayoutConstraint {
        let width = NSLayoutConstraint(item: view, attribute: .width, relatedBy: .equal, toItem: view.superview, attribute: .width, multiplier: ratio, constant: 0)
        width.identifier = "keepWidthWithRatio"
        return width
    }
    
    class func equalWidths(_ views: [NSView]) -> [NSLayoutConstraint] {
        var constraints = [NSLayoutConstraint]()
        for i in 1..<views.count {
            let width = NSLayoutConstraint(item: views[i], attribute: .width, relatedBy: .equal, toItem: views[i-1], attribute: .width, multiplier: 1, constant: 0)
            width.identifier = "equalWidths"
            constraints.append(width)
        }
        return constraints
    }
    
    class func equalHeights(_ views: [NSView]) -> [NSLayoutConstraint] {
        var constraints = [NSLayoutConstraint]()
        for i in 1..<views.count {
            let height = NSLayoutConstraint(item: views[i], attribute: .height, relatedBy: .equal, toItem: views[i-1], attribute: .height, multiplier: 1, constant: 0)
            height.identifier = "equalHeights"
            constraints.append(height)
        }
        return constraints
    }
    
    class func equalWidthsAndHeights(_ views: [NSView]) -> [NSLayoutConstraint] {
        return equalWidths(views) + equalHeights(views)
    }
    
    /// H:|[view1][view2][view3]|
    class func bindHorizontally(_ views: [NSView]) -> [NSLayoutConstraint] {
        var constraints = [NSLayoutConstraint]()
        for i in 0..<views.count {
            let view = views[i]
            
            // leading
            var leading: NSLayoutConstraint
            if i == 0 { // bind first leading to superview
                leading = NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.leading, relatedBy: .equal, toItem: view.superview, attribute: .leading, multiplier: 1, constant: 0)
                leading.identifier = "bindHorizontally.leading.first"
            } else {    // bind all others to the previous view
                leading = NSLayoutConstraint(item: view, attribute: .leading, relatedBy: .equal, toItem: views[i-1], attribute: .trailing, multiplier: 1, constant: 0)
                leading.identifier = "bindHorizontally.leading"
            }
            leading.identifier = "...leading i: \(i)"
            constraints.append(leading)
        }
        
        if views.last != nil {
            let trailing = NSLayoutConstraint(item: views.last!, attribute: .trailing, relatedBy: .equal, toItem: views.last!.superview, attribute: .trailing, multiplier: 1, constant: 0)
            trailing.identifier = "bindHorizontally.trailing count: \(views.count)"
            constraints.append(trailing)
        }
        
        return constraints
    }
    
    /// V:|[view1][view2][view3]|
    class func bindVertically(_ views: [NSView]) -> [NSLayoutConstraint] {
        var constraints = [NSLayoutConstraint]()
        for i in 0..<views.count {
            let view = views[i]
            
            // top
            var top: NSLayoutConstraint
            if i == 0 {
                
                // bind first top to superview
                top = NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.top, relatedBy: .equal, toItem: view.superview, attribute: .top, multiplier: 1, constant: 0)
                top.identifier = "bindVertically.top.first"
            } else {
                
                // bind all others to the previous view
                top = NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: views[i-1], attribute: .bottom, multiplier: 1, constant: 0)
                top.identifier = "bindVertically.top"
            }
            constraints.append(top)
        }
        
        // bottom
        var bottom: NSLayoutConstraint
        if views.last != nil {
            // bind last bottom to superview
            bottom = NSLayoutConstraint(item: views.last!, attribute: .bottom, relatedBy: .equal, toItem: views.last!.superview, attribute: .bottom, multiplier: 1, constant: 0)
            bottom.identifier = "bindVertically.last count: \(views.count)"
            constraints.append(bottom)
        }
        
        return constraints
    }
}
