import UIKit

extension UIView {
    func anchor() -> Anchor { return Anchor(view: self) }
    
    var top: NSLayoutAnchor { return topAnchor }
    var left: NSLayoutAnchor { return leftAnchor }
    var bottom: NSLayoutAnchor { return bottomAnchor }
    var right: NSLayoutAnchor { return rightAnchor }
    var height: NSLayoutDimension { return heightAnchor }
    var width: NSLayoutDimension { return widthAnchor }
    var centerX: NSLayoutXAxisAnchor { return centerXAnchor }
    var centerY: NSLayoutYAxisAnchor { return centerYAnchor }
}

struct Anchor {
    let view: UIView
    let top: NSLayoutConstraint?
    let left: NSLayoutConstraint?
    let bottom: NSLayoutConstraint?
    let right: NSLayoutConstraint?
    let height: NSLayoutConstraint?
    let width: NSLayoutConstraint?
    let centerX: NSLayoutConstraint?
    let centerY: NSLayoutConstraint?
    
    private enum Edge {
        case Top
        case Left
        case Bottom
        case Right
        case Height
        case Width
        case CenterX
        case CenterY
    }
    
    init(view: UIView) {
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
    
    init(view: UIView,
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
    
    private func update(edge edge: Edge, constraint: NSLayoutConstraint) -> Anchor {
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
    
    func top(to edge: NSLayoutAnchor, constant c: CGFloat = 0) -> Anchor {
        return update(edge: .Top, constraint: view.topAnchor.constraintEqualToAnchor(edge, constant: c))
    }
    
    func left(to edge: NSLayoutAnchor, constant c: CGFloat = 0) -> Anchor {
        return update(edge: .Left, constraint: view.leftAnchor.constraintEqualToAnchor(edge, constant: c))
    }
    
    func bottom(to edge: NSLayoutAnchor, constant c: CGFloat = 0) -> Anchor {
        return update(edge: .Bottom, constraint: view.bottomAnchor.constraintEqualToAnchor(edge, constant: c))
    }
    
    func right(to edge: NSLayoutAnchor, constant c: CGFloat = 0) -> Anchor {
        return update(edge: .Right, constraint: view.rightAnchor.constraintEqualToAnchor(edge, constant: c))
    }
    
    func height(constant c: CGFloat) -> Anchor {
        return update(edge: .Height, constraint: view.heightAnchor.constraintEqualToConstant(c))
    }
    
    func height(to dimension: NSLayoutDimension, multiplier m: CGFloat = 1) -> Anchor {
        return update(edge: .Height, constraint: view.heightAnchor.constraintEqualToAnchor(dimension, multiplier: m))
    }
    
    func width(constant c: CGFloat) -> Anchor {
        return update(edge: .Width, constraint: view.widthAnchor.constraintEqualToConstant(c))
    }
    
    func width(to dimension: NSLayoutDimension, multiplier m: CGFloat = 1) -> Anchor {
        return update(edge: .Width, constraint: view.widthAnchor.constraintEqualToAnchor(dimension, multiplier: m))
    }
    
    func centerX(to axis: NSLayoutXAxisAnchor, constant c: CGFloat = 0) -> Anchor {
        return update(edge: .CenterX, constraint: view.centerXAnchor.constraintEqualToAnchor(axis, constant: c))
    }
    
    func centerY(to axis: NSLayoutYAxisAnchor, constant c: CGFloat = 0) -> Anchor {
        return update(edge: .CenterY, constraint: view.centerYAnchor.constraintEqualToAnchor(axis, constant: c))
    }
    
    func activate() -> Anchor {
        view.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [top, left, bottom, right, height, width, centerX, centerY].flatMap({ $0 })
        NSLayoutConstraint.activateConstraints(constraints)
        return self
    }
}