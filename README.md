# Anchor
UIView extensions for concise auto layout setup using NSLayoutAnchor

Convert this mess:
```
mapView.translatesAutoresizingMaskIntoConstraints = false
mapView.leadingAnchor.constraintEqualToAnchor(superview.leadingAnchor).active = true
mapView.trailingAnchor.constraintEqualToAnchor(superview.trailingAnchor).active = true
mapView.topAnchor.constraintEqualToAnchor(superview.topAnchor).active = true
mapView.bottomAnchor.constraintEqualToAnchor(superview.bottomAnchor).active = true
```
into this:
```
mapView.anchorEdgesToSuperview()
```

Or this vomit:
```
container.translatesAutoresizingMaskIntoConstraints = false
container.centerXAnchor.constraintEqualToAnchor(superview.centerXAnchor).active = true
container.centerYAnchor.constraintEqualToAnchor(superview.centerYAnchor).active = true

view1.translatesAutoresizingMaskIntoConstraints = false
view1.leadingAnchor.constraintEqualToAnchor(container.leadingAnchor).active = true
view1.trailingAnchor.constraintEqualToAnchor(container.trailingAnchor).active = true
view1.topAnchor.constraintEqualToAnchor(container.topAnchor).active = true

view2.translatesAutoresizingMaskIntoConstraints = false
view2.topAnchor.constraintEqualToAnchor(view1.bottomAnchor).active = true
view2.leadingAnchor.constraintEqualToAnchor(container.leadingAnchor).active = true
view2.trailingAnchor.constraintEqualToAnchor(container.trailingAnchor).active = true
view2.bottomAnchor.constraintEqualToAnchor(container.bottomAnchor).active = true
```
into this:
```
container.anchorCenterToSuperview()
view1.anchorEdgesToSuperView(omit: .Bottom)
view2.anchorTopTo(view1.bottomAnchor)
view2.anchorEdgesToSuperView(omit: .Top)
```
