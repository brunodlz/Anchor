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
        
        expect(anchor.top?.firstItem).to(beIdenticalTo(view))
        expect(anchor.top?.firstAttribute).to(equal(NSLayoutAttribute.Top))
        expect(anchor.top?.secondItem).to(beIdenticalTo(window))
        expect(anchor.top?.secondAttribute).to(equal(NSLayoutAttribute.Top))
        expect(anchor.top?.constant).to(equal(0))
        expect(anchor.top?.active).to(beFalse())
        
        expect(anchor.left?.firstItem).to(beIdenticalTo(view))
        expect(anchor.left?.firstAttribute).to(equal(NSLayoutAttribute.Left))
        expect(anchor.left?.secondItem).to(beIdenticalTo(window))
        expect(anchor.left?.secondAttribute).to(equal(NSLayoutAttribute.Left))
        expect(anchor.left?.constant).to(equal(1))
        expect(anchor.left?.active).to(beFalse())
        
        expect(anchor.bottom?.firstItem).to(beIdenticalTo(view))
        expect(anchor.bottom?.firstAttribute).to(equal(NSLayoutAttribute.Bottom))
        expect(anchor.bottom?.secondItem).to(beIdenticalTo(window))
        expect(anchor.bottom?.secondAttribute).to(equal(NSLayoutAttribute.Bottom))
        expect(anchor.bottom?.constant).to(equal(-2))
        expect(anchor.bottom?.active).to(beFalse())
        
        expect(anchor.right?.firstItem).to(beIdenticalTo(view))
        expect(anchor.right?.firstAttribute).to(equal(NSLayoutAttribute.Right))
        expect(anchor.right?.secondItem).to(beIdenticalTo(window))
        expect(anchor.right?.secondAttribute).to(equal(NSLayoutAttribute.Right))
        expect(anchor.right?.constant).to(equal(-3))
        expect(anchor.right?.active).to(beFalse())
    }
    
    func testSuperviewAxisAnchors() {
        let xAxisAnchor = view.anchor().centerXToSuperview()
        expect(xAxisAnchor.centerX?.firstItem).to(beIdenticalTo(view))
        expect(xAxisAnchor.centerX?.firstAttribute).to(equal(NSLayoutAttribute.CenterX))
        expect(xAxisAnchor.centerX?.secondItem).to(beIdenticalTo(window))
        expect(xAxisAnchor.centerX?.secondAttribute).to(equal(NSLayoutAttribute.CenterX))
        expect(xAxisAnchor.centerX?.active).to(beFalse())
        
        let yAxisAnchor = view.anchor().centerYToSuperview()
        expect(yAxisAnchor.centerY?.firstItem).to(beIdenticalTo(view))
        expect(yAxisAnchor.centerY?.firstAttribute).to(equal(NSLayoutAttribute.CenterY))
        expect(yAxisAnchor.centerY?.secondItem).to(beIdenticalTo(window))
        expect(yAxisAnchor.centerY?.secondAttribute).to(equal(NSLayoutAttribute.CenterY))
        expect(yAxisAnchor.centerY?.active).to(beFalse())
    }
    
    func testSuperviewEdgesAnchor() {
        let anchor = view.anchor().edgesToSuperview()
        
        expect(anchor.top?.firstItem).to(beIdenticalTo(view))
        expect(anchor.top?.firstAttribute).to(equal(NSLayoutAttribute.Top))
        expect(anchor.top?.secondItem).to(beIdenticalTo(window))
        expect(anchor.top?.secondAttribute).to(equal(NSLayoutAttribute.Top))
        expect(anchor.top?.constant).to(equal(0))
        expect(anchor.top?.active).to(beFalse())
        
        expect(anchor.left?.firstItem).to(beIdenticalTo(view))
        expect(anchor.left?.firstAttribute).to(equal(NSLayoutAttribute.Left))
        expect(anchor.left?.secondItem).to(beIdenticalTo(window))
        expect(anchor.left?.secondAttribute).to(equal(NSLayoutAttribute.Left))
        expect(anchor.left?.constant).to(equal(0))
        expect(anchor.left?.active).to(beFalse())
        
        expect(anchor.bottom?.firstItem).to(beIdenticalTo(view))
        expect(anchor.bottom?.firstAttribute).to(equal(NSLayoutAttribute.Bottom))
        expect(anchor.bottom?.secondItem).to(beIdenticalTo(window))
        expect(anchor.bottom?.secondAttribute).to(equal(NSLayoutAttribute.Bottom))
        expect(anchor.bottom?.constant).to(equal(0))
        expect(anchor.bottom?.active).to(beFalse())
        
        expect(anchor.right?.firstItem).to(beIdenticalTo(view))
        expect(anchor.right?.firstAttribute).to(equal(NSLayoutAttribute.Right))
        expect(anchor.right?.secondItem).to(beIdenticalTo(window))
        expect(anchor.right?.secondAttribute).to(equal(NSLayoutAttribute.Right))
        expect(anchor.right?.constant).to(equal(0))
        expect(anchor.right?.active).to(beFalse())
    }
    
    func testSuperviewEdgesAnchorWithInsets() {
        let anchor = view.anchor()
            .edgesToSuperview(insets: UIEdgeInsets(top: 0, left: 1, bottom: -2, right: -3))
        expect(anchor.top?.constant).to(equal(0))
        expect(anchor.left?.constant).to(equal(1))
        expect(anchor.bottom?.constant).to(equal(-2))
        expect(anchor.right?.constant).to(equal(-3))
    }
    
    func testDimensionsAnchors() {
        let anotherView = UIView()
        
        let constantAnchor = anotherView.anchor().height(constant: 100)
        expect(constantAnchor.height?.constant).to(equal(100))
        expect(constantAnchor.height?.active).to(beFalse())
        
        let viewAnchor = view.anchor().height(to: anotherView.height)
        expect(viewAnchor.height?.firstItem).to(beIdenticalTo(view))
        expect(viewAnchor.height?.firstAttribute).to(equal(NSLayoutAttribute.Height))
        expect(viewAnchor.height?.secondItem).to(beIdenticalTo(anotherView))
        expect(viewAnchor.height?.secondAttribute).to(equal(NSLayoutAttribute.Height))
        expect(viewAnchor.height?.active).to(beFalse())
    }
    
    func testAxisAnchors() {
        let anotherView = UIView()
        window.addSubview(anotherView)
        
        let xAxisAnchor = view.anchor().centerX(to: anotherView.centerX)
        expect(xAxisAnchor.centerX?.firstItem).to(beIdenticalTo(view))
        expect(xAxisAnchor.centerX?.firstAttribute).to(equal(NSLayoutAttribute.CenterX))
        expect(xAxisAnchor.centerX?.secondItem).to(beIdenticalTo(anotherView))
        expect(xAxisAnchor.centerX?.secondAttribute).to(equal(NSLayoutAttribute.CenterX))
        expect(xAxisAnchor.centerX?.active).to(beFalse())
        
        let yAxisAnchor = view.anchor().centerY(to: anotherView.centerY)
        expect(yAxisAnchor.centerY?.firstItem).to(beIdenticalTo(view))
        expect(yAxisAnchor.centerY?.firstAttribute).to(equal(NSLayoutAttribute.CenterY))
        expect(yAxisAnchor.centerY?.secondItem).to(beIdenticalTo(anotherView))
        expect(yAxisAnchor.centerY?.secondAttribute).to(equal(NSLayoutAttribute.CenterY))
        expect(yAxisAnchor.centerY?.active).to(beFalse())
    }
    
    func testActivatingAnchor() {
        expect(self.view.translatesAutoresizingMaskIntoConstraints).to(beTrue())
        let anchor = view.anchor()
            .topToSuperview()
            .leftToSuperview()
            .activate()
        
        expect(self.view.translatesAutoresizingMaskIntoConstraints).to(beFalse())
        expect(anchor.top?.active).to(beTrue())
        expect(anchor.left?.active).to(beTrue())
    }
}
