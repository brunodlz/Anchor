import XCTest
import Nimble
import Anchor

class AxisTests: XCTestCase {
    var window: UIWindow!
    var view: UIView!
    
    override func setUp() {
        super.setUp()
        window = UIWindow(frame: CGRect(x: 0, y: 0, width: 500, height: 500))
        view = UIView()
        
        window.addSubview(view)
    }
    
    func testAxisAnchors() {
        let anotherView = UIView()
        let anchor = view.anchor().centerX(to: anotherView.centerX).centerY(to: anotherView.centerY)
        
        expect(anchor.centerX?.firstItem).to(beIdenticalTo(view))
        expect(anchor.centerX?.firstAttribute).to(equal(NSLayoutAttribute.CenterX))
        expect(anchor.centerX?.secondItem).to(beIdenticalTo(anotherView))
        expect(anchor.centerX?.secondAttribute).to(equal(NSLayoutAttribute.CenterX))
        expect(anchor.centerX?.relation).to(equal(NSLayoutRelation.Equal))
        
        expect(anchor.centerY?.firstItem).to(beIdenticalTo(view))
        expect(anchor.centerY?.firstAttribute).to(equal(NSLayoutAttribute.CenterY))
        expect(anchor.centerY?.secondItem).to(beIdenticalTo(anotherView))
        expect(anchor.centerY?.secondAttribute).to(equal(NSLayoutAttribute.CenterY))
        expect(anchor.centerY?.relation).to(equal(NSLayoutRelation.Equal))
    }
    
    func testSuperviewAxisAnchors() {
        let anchor = view.anchor().centerXToSuperview().centerYToSuperview()
        
        expect(anchor.centerX?.firstItem).to(beIdenticalTo(view))
        expect(anchor.centerX?.firstAttribute).to(equal(NSLayoutAttribute.CenterX))
        expect(anchor.centerX?.secondItem).to(beIdenticalTo(window))
        expect(anchor.centerX?.secondAttribute).to(equal(NSLayoutAttribute.CenterX))
        expect(anchor.centerX?.relation).to(equal(NSLayoutRelation.Equal))
        
        expect(anchor.centerY?.firstItem).to(beIdenticalTo(view))
        expect(anchor.centerY?.firstAttribute).to(equal(NSLayoutAttribute.CenterY))
        expect(anchor.centerY?.secondItem).to(beIdenticalTo(window))
        expect(anchor.centerY?.secondAttribute).to(equal(NSLayoutAttribute.CenterY))
        expect(anchor.centerY?.relation).to(equal(NSLayoutRelation.Equal))
    }
    
    func testSuperviewAnchorCenter() {
        let centerAnchor = view.anchor().centerToSuperview()
        expect(centerAnchor.centerX).toNot(beNil())
        expect(centerAnchor.centerY).toNot(beNil())
    }
}
