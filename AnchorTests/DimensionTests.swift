import XCTest
import Nimble
import Anchor

class DimensionTests: XCTestCase {
    var window: UIWindow!
    var view: UIView!
    
    override func setUp() {
        super.setUp()
        window = UIWindow(frame: CGRect(x: 0, y: 0, width: 500, height: 500))
        view = UIView()
        
        window.addSubview(view)
    }
    
    func testDimensionAnchorsToConstant() {
        let anchor = view.anchor().width(constant: 100).height(constant: 101)
        
        expect(anchor.width?.firstItem).to(beIdenticalTo(view))
        expect(anchor.width?.relation).to(equal(NSLayoutRelation.Equal))
        expect(anchor.width?.constant).to(equal(100))
        expect(anchor.height?.firstItem).to(beIdenticalTo(view))
        expect(anchor.height?.relation).to(equal(NSLayoutRelation.Equal))
        expect(anchor.height?.constant).to(equal(101))
    }
    
    func testDimensionAnchorsToAnchors() {
        let anotherView = UIView()
        let anchor = view.anchor().width(to: anotherView.width).height(to: anotherView.height)

        expect(anchor.width?.firstItem).to(beIdenticalTo(view))
        expect(anchor.width?.firstAttribute).to(equal(NSLayoutAttribute.Width))
        expect(anchor.width?.secondItem).to(beIdenticalTo(anotherView))
        expect(anchor.width?.secondAttribute).to(equal(NSLayoutAttribute.Width))
        expect(anchor.width?.relation).to(equal(NSLayoutRelation.Equal))
        
        expect(anchor.height?.firstItem).to(beIdenticalTo(view))
        expect(anchor.height?.firstAttribute).to(equal(NSLayoutAttribute.Height))
        expect(anchor.height?.secondItem).to(beIdenticalTo(anotherView))
        expect(anchor.height?.secondAttribute).to(equal(NSLayoutAttribute.Height))
        expect(anchor.height?.relation).to(equal(NSLayoutRelation.Equal))
    }
}
