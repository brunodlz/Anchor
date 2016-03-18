The MIT License (MIT)

Copyright (c) 2016 Hsien-Chiao Lee

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

import UIKit

extension UIView {
  
  // MARK: superview
  func anchorTopToSuperview() -> NSLayoutConstraint {
    return anchorTopTo((superview?.topAnchor)!)
  }
  
  func anchorBottomToSuperview() -> NSLayoutConstraint {
    return anchorBottomTo((superview?.bottomAnchor)!)
  }
  
  func anchorLeftToSuperview() -> NSLayoutConstraint {
    return anchorLeftTo((superview?.leftAnchor)!)
  }
  
  func anchorRightToSuperview() -> NSLayoutConstraint {
    return anchorRightTo((superview?.rightAnchor)!)
  }
  
  func anchorLeadingToSuperview() -> NSLayoutConstraint {
    return anchorLeadingTo((superview?.leadingAnchor)!)
  }
  
  func anchorTrailingToSuperview() -> NSLayoutConstraint {
    return anchorTrailingTo((superview?.trailingAnchor)!)
  }
  
  func anchorCenterXToSuperview() -> NSLayoutConstraint {
    return anchor(self.centerXAnchor, toAnchor: (superview?.centerXAnchor)!)
  }
  
  func anchorCenterYToSuperview() -> NSLayoutConstraint {
    return anchor(self.centerYAnchor, toAnchor: (superview?.centerYAnchor)!)
  }
  
  func anchorCenterToSuperview() {
    anchorCenterXToSuperview()
    anchorCenterYToSuperview()
  }
  
  func anchorEdgesToSuperView() {
    anchorTopToSuperview()
    anchorBottomToSuperview()
    anchorLeftToSuperview()
    anchorRightToSuperview()
  }
  
  func anchorEdgesToSuperView(omit omit: NSLayoutAttribute) {
    var anchors = [anchorTopToSuperview,
      anchorBottomToSuperview,
      anchorLeftToSuperview,
      anchorRightToSuperview]
    switch excluding {
    case .Top: _ = anchors.removeAtIndex(0)
    case .Bottom: _ = anchors.removeAtIndex(1)
    case .Leading, .Left: _ = anchors.removeAtIndex(2)
    case .Trailing, .Right: _ = anchors.removeAtIndex(3)
    default: break
    }
    
    for anchor in anchors {
      anchor()
    }
  }
  
  // MARK: anchorTo NSLayoutAnchor
  func anchorTopTo(toAnchor: NSLayoutAnchor, offset: CGFloat = 0) -> NSLayoutConstraint {
    return anchor(self.topAnchor, toAnchor: toAnchor, offset: offset)
  }
  
  func anchorBottomTo(toAnchor: NSLayoutAnchor) -> NSLayoutConstraint {
    return anchor(self.bottomAnchor, toAnchor: toAnchor)
  }
  
  func anchorLeftTo(toAnchor: NSLayoutAnchor, offset: CGFloat = 0) -> NSLayoutConstraint {
    return anchor(self.leftAnchor, toAnchor: toAnchor, offset: offset)
  }
  
  func anchorRightTo(toAnchor: NSLayoutAnchor, offset: CGFloat = 0) -> NSLayoutConstraint {
    return anchor(self.rightAnchor, toAnchor: toAnchor, offset: offset)
  }
  
  func anchorLeadingTo(toAnchor: NSLayoutAnchor) -> NSLayoutConstraint {
    return anchor(self.leadingAnchor, toAnchor: toAnchor)
  }
  
  func anchorTrailingTo(toAnchor: NSLayoutAnchor) -> NSLayoutConstraint {
    return anchor(self.trailingAnchor, toAnchor: toAnchor)
  }
  
  // MARK: private
  private func anchor(anchor: NSLayoutAnchor,
    toAnchor: NSLayoutAnchor,
    offset: CGFloat = 0) -> NSLayoutConstraint {
      self.translatesAutoresizingMaskIntoConstraints = false
      let constraint = anchor.constraintEqualToAnchor(toAnchor, constant: offset)
      constraint.active = true
      return constraint
  }
}
