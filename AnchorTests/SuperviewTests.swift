import XCTest
import Nimble
import Anchor

class SuperviewTests: XCTestCase {
    var window: UIWindow!
    var view: UIView!
    
    override func setUp() {
        super.setUp()
        window = UIWindow(frame: CGRect(x: 0, y: 0, width: 500, height: 500))
        view = UIView()
        
        window.addSubview(view)
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
