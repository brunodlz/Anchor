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
        expect(anchor.top?.active).to(beTrue())
        expect(anchor.left?.active).to(beTrue())
    }
    
    func testEdgeAnchors() {
        let anchor = view.anchor()
            .top(to: window.top)
            .left(to: window.left, constant: 1)
            .bottom(to: window.bottom, constant: -2)
            .right(to: window.right, constant: -3)
        
        expect(anchor.top?.firstItem).to(beIdenticalTo(view))
        expect(anchor.top?.firstAttribute).to(equal(NSLayoutAttribute.Top))
        expect(anchor.top?.secondItem).to(beIdenticalTo(window))
        expect(anchor.top?.secondAttribute).to(equal(NSLayoutAttribute.Top))
        expect(anchor.top?.relation).to(equal(NSLayoutRelation.Equal))
        expect(anchor.top?.constant).to(equal(0))
        
        expect(anchor.left?.firstItem).to(beIdenticalTo(view))
        expect(anchor.left?.firstAttribute).to(equal(NSLayoutAttribute.Left))
        expect(anchor.left?.secondItem).to(beIdenticalTo(window))
        expect(anchor.left?.secondAttribute).to(equal(NSLayoutAttribute.Left))
        expect(anchor.left?.relation).to(equal(NSLayoutRelation.Equal))
        expect(anchor.left?.constant).to(equal(1))
        
        expect(anchor.bottom?.firstItem).to(beIdenticalTo(view))
        expect(anchor.bottom?.firstAttribute).to(equal(NSLayoutAttribute.Bottom))
        expect(anchor.bottom?.secondItem).to(beIdenticalTo(window))
        expect(anchor.bottom?.secondAttribute).to(equal(NSLayoutAttribute.Bottom))
        expect(anchor.bottom?.relation).to(equal(NSLayoutRelation.Equal))
        expect(anchor.bottom?.constant).to(equal(-2))
        
        expect(anchor.right?.firstItem).to(beIdenticalTo(view))
        expect(anchor.right?.firstAttribute).to(equal(NSLayoutAttribute.Right))
        expect(anchor.right?.secondItem).to(beIdenticalTo(window))
        expect(anchor.right?.secondAttribute).to(equal(NSLayoutAttribute.Right))
        expect(anchor.right?.relation).to(equal(NSLayoutRelation.Equal))
        expect(anchor.right?.constant).to(equal(-3))
    }
    
    func testGreaterOrEqualAnchor() {
        let anchor = view.anchor()
            .top(greaterOrEqual: window.top)
            .left(greaterOrEqual: window.left, constant: 1)
            .bottom(greaterOrEqual: window.bottom, constant: -2)
            .right(greaterOrEqual: window.right, constant: -3)
        
        expect(anchor.top?.relation).to(equal(NSLayoutRelation.GreaterThanOrEqual))
        expect(anchor.top?.constant).to(equal(0))
        expect(anchor.left?.relation).to(equal(NSLayoutRelation.GreaterThanOrEqual))
        expect(anchor.left?.constant).to(equal(1))
        expect(anchor.bottom?.relation).to(equal(NSLayoutRelation.GreaterThanOrEqual))
        expect(anchor.bottom?.constant).to(equal(-2))
        expect(anchor.right?.relation).to(equal(NSLayoutRelation.GreaterThanOrEqual))
        expect(anchor.right?.constant).to(equal(-3))
    }
    
    func testLessOrEqualAnchor() {
        let anchor = view.anchor()
            .top(lesserOrEqual: window.top)
            .left(lesserOrEqual: window.left, constant: 1)
            .bottom(lesserOrEqual: window.bottom, constant: -2)
            .right(lesserOrEqual: window.right, constant: -3)
        
        expect(anchor.top?.relation).to(equal(NSLayoutRelation.LessThanOrEqual))
        expect(anchor.top?.constant).to(equal(0))
        expect(anchor.left?.relation).to(equal(NSLayoutRelation.LessThanOrEqual))
        expect(anchor.left?.constant).to(equal(1))
        expect(anchor.bottom?.relation).to(equal(NSLayoutRelation.LessThanOrEqual))
        expect(anchor.bottom?.constant).to(equal(-2))
        expect(anchor.right?.relation).to(equal(NSLayoutRelation.LessThanOrEqual))
        expect(anchor.right?.constant).to(equal(-3))
    }
    
    func testSuperviewAnchorsWithOutSuperview() {
        view.removeFromSuperview()
        
        expect(self.view.anchor().topToSuperview().top).to(beNil())
        expect(self.view.anchor().leftToSuperview().left).to(beNil())
        expect(self.view.anchor().bottomToSuperview().bottom).to(beNil())
        expect(self.view.anchor().rightToSuperview().right).to(beNil())
    }
    
    func testSuperviewAnchorsWithSuperview() {
        let anchor = view.anchor()
            .topToSuperview()
            .leftToSuperview(constant: 1)
            .bottomToSuperview(constant: -2)
            .rightToSuperview(constant: -3)
        
        expect(anchor.top).toNot(beNil())
        expect(anchor.left).toNot(beNil())
        expect(anchor.bottom).toNot(beNil())
        expect(anchor.right).toNot(beNil())
    }
    
    func testSuperviewEdgesAnchor() {
        let anchor = view.anchor().edgesToSuperview()
        
        expect(anchor.top).toNot(beNil())
        expect(anchor.left).toNot(beNil())
        expect(anchor.bottom).toNot(beNil())
        expect(anchor.right).toNot(beNil())
    }
    
    func testSuperviewEdgesAnchorWithInsets() {
        let anchor = view.anchor()
            .edgesToSuperview(insets: UIEdgeInsets(top: 0, left: 1, bottom: -2, right: -3))
        
        expect(anchor.top?.constant).to(equal(0))
        expect(anchor.left?.constant).to(equal(1))
        expect(anchor.bottom?.constant).to(equal(-2))
        expect(anchor.right?.constant).to(equal(-3))
    }
    
    func testSuperviewEdgesAnchorWithOmittedEdge() {
        let anchor = view.anchor().edgesToSuperview(omitEdge: .Bottom)
        
        expect(anchor.top).toNot(beNil())
        expect(anchor.left).toNot(beNil())
        expect(anchor.bottom).to(beNil())
        expect(anchor.right).toNot(beNil())
    }
}
