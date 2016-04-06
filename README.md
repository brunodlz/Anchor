# Anchor
UIView extensions for concise auto layout setup using NSLayoutAnchor

Convert this mess:
```
view.translatesAutoresizingMaskIntoConstraints = false
view.leadingAnchor.constraintEqualToAnchor(superview.leadingAnchor).active = true
view.trailingAnchor.constraintEqualToAnchor(superview.trailingAnchor).active = true
view.topAnchor.constraintEqualToAnchor(superview.topAnchor).active = true
view.bottomAnchor.constraintEqualToAnchor(superview.bottomAnchor).active = true
```
into this:
```
view.anchor().edgesToSuperview().activate()
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
container.anchor().centerToSuperview().activate()
view1.anchor().edgesToSuperView(omitEdge: .Bottom).activate()
view2.anchor()
     .top(to: view1.bottom)
     .edgesToSuperview(omitEdge: .Top)
     .activate()
```
