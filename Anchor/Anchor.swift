import UIKit

public extension UIView {
    public func anchor() -> Anchor { return Anchor(view: self) }
    
    public var top: NSLayoutAnchor { return topAnchor }
    public var left: NSLayoutAnchor { return leftAnchor }
    public var bottom: NSLayoutAnchor { return bottomAnchor }
    public var right: NSLayoutAnchor { return rightAnchor }
    public var height: NSLayoutDimension { return heightAnchor }
    public var width: NSLayoutDimension { return widthAnchor }
    public var centerX: NSLayoutXAxisAnchor { return centerXAnchor }
    public var centerY: NSLayoutYAxisAnchor { return centerYAnchor }
}

public struct Anchor {
    public let view: UIView
    public let top: NSLayoutConstraint?
    public let left: NSLayoutConstraint?
    public let bottom: NSLayoutConstraint?
    public let right: NSLayoutConstraint?
    public let height: NSLayoutConstraint?
    public let width: NSLayoutConstraint?
    public let centerX: NSLayoutConstraint?
    public let centerY: NSLayoutConstraint?
    
    private init(view: UIView) {
        self.view = view
        top = nil
        left = nil
        bottom = nil
        right = nil
        height = nil
        width = nil
        centerX = nil
        centerY = nil
    }
    
    private init(view: UIView,
         top: NSLayoutConstraint?,
         left: NSLayoutConstraint?,
         bottom: NSLayoutConstraint?,
         right: NSLayoutConstraint?,
         height: NSLayoutConstraint?,
         width: NSLayoutConstraint?,
         centerX: NSLayoutConstraint?,
         centerY: NSLayoutConstraint?)
    {
        self.view = view
        self.top = top
        self.left = left
        self.bottom = bottom
        self.right = right
        self.height = height
        self.width = width
        self.centerX = centerX
        self.centerY = centerY
    }
    
    private func update(edge edge: NSLayoutAttribute, constraint: NSLayoutConstraint?) -> Anchor {
        var top = self.top
        var left = self.left
        var bottom = self.bottom
        var right = self.right
        var height = self.height
        var width = self.width
        var centerX = self.centerX
        var centerY = self.centerY
        
        switch edge {
        case .Top: top = constraint
        case .Left: left = constraint
        case .Bottom: bottom = constraint
        case .Right: right = constraint
        case .Height: height = constraint
        case .Width: width = constraint
        case .CenterX: centerX = constraint
        case .CenterY: centerY = constraint
        default: return self
        }
        
        return Anchor(
            view: self.view,
            top: top,
            left: left,
            bottom: bottom,
            right: right,
            height: height,
            width: width,
            centerX: centerX,
            centerY: centerY)
    }
    
    private func insert(anchor: Anchor) -> Anchor {
        return Anchor(
            view: self.view,
            top: anchor.top ?? top,
            left: anchor.left ?? left,
            bottom: anchor.bottom ?? bottom,
            right: anchor.right ?? right,
            height: anchor.height ?? height,
            width: anchor.width ?? width,
            centerX: anchor.centerX ?? centerX,
            centerY: anchor.centerY ?? centerY)
    }
    
    // MARK: Anchor to superview edges
    public func topToSuperview(constant c: CGFloat = 0) -> Anchor {
        guard let superview = view.superview else {
            return self
        }
        return top(to: superview.top, constant: c)
    }
    
    public func leftToSuperview(constant c: CGFloat = 0) -> Anchor {
        guard let superview = view.superview else {
            return self
        }
        return left(to: superview.left, constant: c)
    }
    
    public func bottomToSuperview(constant c: CGFloat = 0) -> Anchor {
        guard let superview = view.superview else {
            return self
        }
        return bottom(to: superview.bottom, constant: c)
    }
    
    public func rightToSuperview(constant c: CGFloat = 0) -> Anchor {
        guard let superview = view.superview else {
            return self
        }
        return right(to: superview.right, constant: c)
    }
    
    public func edgesToSuperview(omitEdge e: NSLayoutAttribute = .NotAnAttribute, insets: UIEdgeInsets = UIEdgeInsetsZero) -> Anchor {
        let superviewAnchors = topToSuperview(constant: insets.top)
            .leftToSuperview(constant: insets.left)
            .bottomToSuperview(constant: insets.bottom)
            .rightToSuperview(constant: insets.right)
            .update(edge: e, constraint: nil)
        return self.insert(superviewAnchors)
    }
    
    // MARK: Anchor to superview axises
    public func centerXToSuperview() -> Anchor {
        guard let superview = view.superview else {
            return self
        }
        return centerX(to: superview.centerX)
    }
    
    public func centerYToSuperview() -> Anchor {
        guard let superview = view.superview else {
            return self
        }
        return centerY(to: superview.centerY)
    }
    
    public func centerToSuperview() -> Anchor {
        guard let superview = view.superview else {
            return self
        }
        return centerX(to: superview.centerX)
            .centerY(to: superview.centerY)
    }
    
    // MARK: Anchor to
    public func top(to anchor: NSLayoutAnchor, constant c: CGFloat = 0) -> Anchor {
        return update(edge: .Top, constraint: view.top.constraintEqualToAnchor(anchor, constant: c))
    }
    
    public func left(to anchor: NSLayoutAnchor, constant c: CGFloat = 0) -> Anchor {
        return update(edge: .Left, constraint: view.left.constraintEqualToAnchor(anchor, constant: c))
    }
    
    public func bottom(to anchor: NSLayoutAnchor, constant c: CGFloat = 0) -> Anchor {
        return update(edge: .Bottom, constraint: view.bottom.constraintEqualToAnchor(anchor, constant: c))
    }
    
    public func right(to anchor: NSLayoutAnchor, constant c: CGFloat = 0) -> Anchor {
        return update(edge: .Right, constraint: view.right.constraintEqualToAnchor(anchor, constant: c))
    }
    
    // MARK: Anchor greaterOrEqual
    public func top(greaterOrEqual anchor: NSLayoutAnchor, constant c: CGFloat = 0) -> Anchor {
        return update(edge: .Top, constraint: view.top.constraintGreaterThanOrEqualToAnchor(anchor, constant: c))
    }
    
    public func left(greaterOrEqual anchor: NSLayoutAnchor, constant c: CGFloat = 0) -> Anchor {
        return update(edge: .Left, constraint: view.left.constraintGreaterThanOrEqualToAnchor(anchor, constant: c))
    }
    
    public func bottom(greaterOrEqual anchor: NSLayoutAnchor, constant c: CGFloat = 0) -> Anchor {
        return update(edge: .Bottom, constraint: view.bottom.constraintGreaterThanOrEqualToAnchor(anchor, constant: c))
    }
    
    public func right(greaterOrEqual anchor: NSLayoutAnchor, constant c: CGFloat = 0) -> Anchor {
        return update(edge: .Right, constraint: view.right.constraintGreaterThanOrEqualToAnchor(anchor, constant: c))
    }
    
    // MARK: Anchor lessOrEqual
    public func top(lesserOrEqual anchor: NSLayoutAnchor, constant c: CGFloat = 0) -> Anchor {
        return update(edge: .Top, constraint: view.top.constraintLessThanOrEqualToAnchor(anchor, constant: c))
    }
    
    public func left(lesserOrEqual anchor: NSLayoutAnchor, constant c: CGFloat = 0) -> Anchor {
        return update(edge: .Left, constraint: view.left.constraintLessThanOrEqualToAnchor(anchor, constant: c))
    }
    
    public func bottom(lesserOrEqual anchor: NSLayoutAnchor, constant c: CGFloat = 0) -> Anchor {
        return update(edge: .Bottom, constraint: view.bottom.constraintLessThanOrEqualToAnchor(anchor, constant: c))
    }
    
    public func right(lesserOrEqual anchor: NSLayoutAnchor, constant c: CGFloat = 0) -> Anchor {
        return update(edge: .Right, constraint: view.right.constraintLessThanOrEqualToAnchor(anchor, constant: c))
    }
    
    // MARK: Dimension anchors
    public func height(constant c: CGFloat) -> Anchor {
        return update(edge: .Height, constraint: view.height.constraintEqualToConstant(c))
    }
    
    public func height(to dimension: NSLayoutDimension, multiplier m: CGFloat = 1) -> Anchor {
        return update(edge: .Height, constraint: view.height.constraintEqualToAnchor(dimension, multiplier: m))
    }
    
    public func width(constant c: CGFloat) -> Anchor {
        return update(edge: .Width, constraint: view.width.constraintEqualToConstant(c))
    }
    
    public func width(to dimension: NSLayoutDimension, multiplier m: CGFloat = 1) -> Anchor {
        return update(edge: .Width, constraint: view.width.constraintEqualToAnchor(dimension, multiplier: m))
    }
    
    // MARK: Axis anchors
    public func centerX(to axis: NSLayoutXAxisAnchor, constant c: CGFloat = 0) -> Anchor {
        return update(edge: .CenterX, constraint: view.centerX.constraintEqualToAnchor(axis, constant: c))
    }
    
    public func centerY(to axis: NSLayoutYAxisAnchor, constant c: CGFloat = 0) -> Anchor {
        return update(edge: .CenterY, constraint: view.centerY.constraintEqualToAnchor(axis, constant: c))
    }
    
    // MARK: Activation
    public func activate() -> Anchor {
        view.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [top, left, bottom, right, height, width, centerX, centerY].flatMap({ $0 })
        NSLayoutConstraint.activateConstraints(constraints)
        return self
    }
}