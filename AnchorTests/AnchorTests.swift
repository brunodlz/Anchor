import XCTest
import Nimble
import Anchor

class AnchorTests: XCTestCase {
    var window: UIWindow!
    var view: UIView!
    
    override func setUp() {
        super.setUp()
        window = UIWindow(frame: CGRect(x: 0, y: 0, width: 500, height: 500))
        view = UIView()
        
        window.addSubview(view)
    }
    
    func testInitialAnchor() {
        expect(self.view.anchor().view).to(beIdenticalTo(view))
    }
    
    func testChainingAndActivatingAnchor() {
        expect(self.view.translatesAutoresizingMaskIntoConstraints).to(beTrue())
        let anchor = view.anchor()
            .topToSuperview()
            .leftToSuperview()
            .activate()
        
        expect(self.view.translatesAutoresizingMaskIntoConstraints).to(beFalse())
        expect(anchor.top?.isActive).to(beTrue())
        expect(anchor.left?.isActive).to(beTrue())
    }
    
    func testEdgeAnchors() {
        let anchor = view.anchor()
            .top(to: window.top)
            .left(to: window.left, constant: 1)
            .bottom(to: window.bottom, constant: -2)
            .right(to: window.right, constant: -3)
        
        expect(anchor.top?.firstItem).to(beIdenticalTo(view))
        expect(anchor.top?.firstAttribute).to(equal(NSLayoutAttribute.top))
        expect(anchor.top?.secondItem).to(beIdenticalTo(window))
        expect(anchor.top?.secondAttribute).to(equal(NSLayoutAttribute.top))
        expect(anchor.top?.relation).to(equal(NSLayoutRelation.equal))
        expect(anchor.top?.constant).to(equal(0))
        
        expect(anchor.left?.firstItem).to(beIdenticalTo(view))
        expect(anchor.left?.firstAttribute).to(equal(NSLayoutAttribute.left))
        expect(anchor.left?.secondItem).to(beIdenticalTo(window))
        expect(anchor.left?.secondAttribute).to(equal(NSLayoutAttribute.left))
        expect(anchor.left?.relation).to(equal(NSLayoutRelation.equal))
        expect(anchor.left?.constant).to(equal(1))
        
        expect(anchor.bottom?.firstItem).to(beIdenticalTo(view))
        expect(anchor.bottom?.firstAttribute).to(equal(NSLayoutAttribute.bottom))
        expect(anchor.bottom?.secondItem).to(beIdenticalTo(window))
        expect(anchor.bottom?.secondAttribute).to(equal(NSLayoutAttribute.bottom))
        expect(anchor.bottom?.relation).to(equal(NSLayoutRelation.equal))
        expect(anchor.bottom?.constant).to(equal(-2))
        
        expect(anchor.right?.firstItem).to(beIdenticalTo(view))
        expect(anchor.right?.firstAttribute).to(equal(NSLayoutAttribute.right))
        expect(anchor.right?.secondItem).to(beIdenticalTo(window))
        expect(anchor.right?.secondAttribute).to(equal(NSLayoutAttribute.right))
        expect(anchor.right?.relation).to(equal(NSLayoutRelation.equal))
        expect(anchor.right?.constant).to(equal(-3))
    }
    
    func testGreaterOrEqualAnchor() {
        let anchor = view.anchor()
            .top(greaterOrEqual: window.top)
            .left(greaterOrEqual: window.left, constant: 1)
            .bottom(greaterOrEqual: window.bottom, constant: -2)
            .right(greaterOrEqual: window.right, constant: -3)
        
        expect(anchor.top?.relation).to(equal(NSLayoutRelation.greaterThanOrEqual))
        expect(anchor.top?.constant).to(equal(0))
        expect(anchor.left?.relation).to(equal(NSLayoutRelation.greaterThanOrEqual))
        expect(anchor.left?.constant).to(equal(1))
        expect(anchor.bottom?.relation).to(equal(NSLayoutRelation.greaterThanOrEqual))
        expect(anchor.bottom?.constant).to(equal(-2))
        expect(anchor.right?.relation).to(equal(NSLayoutRelation.greaterThanOrEqual))
        expect(anchor.right?.constant).to(equal(-3))
    }
    
    func testLessOrEqualAnchor() {
        let anchor = view.anchor()
            .top(lesserOrEqual: window.top)
            .left(lesserOrEqual: window.left, constant: 1)
            .bottom(lesserOrEqual: window.bottom, constant: -2)
            .right(lesserOrEqual: window.right, constant: -3)
        
        expect(anchor.top?.relation).to(equal(NSLayoutRelation.lessThanOrEqual))
        expect(anchor.top?.constant).to(equal(0))
        expect(anchor.left?.relation).to(equal(NSLayoutRelation.lessThanOrEqual))
        expect(anchor.left?.constant).to(equal(1))
        expect(anchor.bottom?.relation).to(equal(NSLayoutRelation.lessThanOrEqual))
        expect(anchor.bottom?.constant).to(equal(-2))
        expect(anchor.right?.relation).to(equal(NSLayoutRelation.lessThanOrEqual))
        expect(anchor.right?.constant).to(equal(-3))
    }    
}
