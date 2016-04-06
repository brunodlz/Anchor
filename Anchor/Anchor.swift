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
        return topToSuperview(constant: insets.top)
            .leftToSuperview(constant: insets.left)
            .bottomToSuperview(constant: insets.bottom)
            .rightToSuperview(constant: insets.right)
            .update(edge: e, constraint: nil)
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
    
    // MARK: Anchor to edges
    public func top(to edge: NSLayoutAnchor, constant c: CGFloat = 0) -> Anchor {
        return update(edge: .Top, constraint: view.topAnchor.constraintEqualToAnchor(edge, constant: c))
    }
    
    public func left(to edge: NSLayoutAnchor, constant c: CGFloat = 0) -> Anchor {
        return update(edge: .Left, constraint: view.leftAnchor.constraintEqualToAnchor(edge, constant: c))
    }
    
    public func bottom(to edge: NSLayoutAnchor, constant c: CGFloat = 0) -> Anchor {
        return update(edge: .Bottom, constraint: view.bottomAnchor.constraintEqualToAnchor(edge, constant: c))
    }
    
    public func right(to edge: NSLayoutAnchor, constant c: CGFloat = 0) -> Anchor {
        return update(edge: .Right, constraint: view.rightAnchor.constraintEqualToAnchor(edge, constant: c))
    }
    
    // MARK: Anchor greaterOrEqual
    public func top(greaterOrEqual a: NSLayoutAnchor, constant c: CGFloat = 0) -> Anchor {
        return update(edge: .Top, constraint: view.topAnchor.constraintGreaterThanOrEqualToAnchor(a, constant: c))
    }
    
    public func left(greaterOrEqual a: NSLayoutAnchor, constant c: CGFloat = 0) -> Anchor {
        return update(edge: .Left, constraint: view.leftAnchor.constraintGreaterThanOrEqualToAnchor(a, constant: c))
    }
    
    public func bottom(greaterOrEqual a: NSLayoutAnchor, constant c: CGFloat = 0) -> Anchor {
        return update(edge: .Bottom, constraint: view.bottomAnchor.constraintGreaterThanOrEqualToAnchor(a, constant: c))
    }
    
    public func right(greaterOrEqual a: NSLayoutAnchor, constant c: CGFloat = 0) -> Anchor {
        return update(edge: .Right, constraint: view.rightAnchor.constraintGreaterThanOrEqualToAnchor(a, constant: c))
    }
    
    // MARK: Anchor lessOrEqual
    public func top(lesserOrEqual a: NSLayoutAnchor, constant c: CGFloat = 0) -> Anchor {
        return update(edge: .Top, constraint: view.topAnchor.constraintLessThanOrEqualToAnchor(a, constant: c))
    }
    
    public func left(lesserOrEqual a: NSLayoutAnchor, constant c: CGFloat = 0) -> Anchor {
        return update(edge: .Left, constraint: view.leftAnchor.constraintLessThanOrEqualToAnchor(a, constant: c))
    }
    
    public func bottom(lesserOrEqual a: NSLayoutAnchor, constant c: CGFloat = 0) -> Anchor {
        return update(edge: .Bottom, constraint: view.bottomAnchor.constraintLessThanOrEqualToAnchor(a, constant: c))
    }
    
    public func right(lesserOrEqual a: NSLayoutAnchor, constant c: CGFloat = 0) -> Anchor {
        return update(edge: .Right, constraint: view.rightAnchor.constraintLessThanOrEqualToAnchor(a, constant: c))
    }
    
    // MARK: Anchor to dimensions
    public func height(constant c: CGFloat) -> Anchor {
        return update(edge: .Height, constraint: view.heightAnchor.constraintEqualToConstant(c))
    }
    
    public func height(to dimension: NSLayoutDimension, multiplier m: CGFloat = 1) -> Anchor {
        return update(edge: .Height, constraint: view.heightAnchor.constraintEqualToAnchor(dimension, multiplier: m))
    }
    
    public func width(constant c: CGFloat) -> Anchor {
        return update(edge: .Width, constraint: view.widthAnchor.constraintEqualToConstant(c))
    }
    
    public func width(to dimension: NSLayoutDimension, multiplier m: CGFloat = 1) -> Anchor {
        return update(edge: .Width, constraint: view.widthAnchor.constraintEqualToAnchor(dimension, multiplier: m))
    }
    
    // MAKR: Anchor to axises
    public func centerX(to axis: NSLayoutXAxisAnchor, constant c: CGFloat = 0) -> Anchor {
        return update(edge: .CenterX, constraint: view.centerXAnchor.constraintEqualToAnchor(axis, constant: c))
    }
    
    public func centerY(to axis: NSLayoutYAxisAnchor, constant c: CGFloat = 0) -> Anchor {
        return update(edge: .CenterY, constraint: view.centerYAnchor.constraintEqualToAnchor(axis, constant: c))
    }
    
    public func activate() -> Anchor {
        view.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [top, left, bottom, right, height, width, centerX, centerY].flatMap({ $0 })
        NSLayoutConstraint.activateConstraints(constraints)
        return self
    }
}