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
  
  func anchorEdgesToSuperView(excluding: NSLayoutAttribute) {
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
