import UIKit

class PassthroughView: UIView {

    // The closure to be executed when a tap is recognized.
    var onTap: (() -> Void)?

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        // 1. First, perform the standard hit test. This will return `self` if the touch
        // is within this view's bounds and not on a subview.
        let hitView = super.hitTest(point, with: event)

        // 2. If the hit view is not `self`, it means the touch was either on a subview
        // or outside of this view's bounds. In either case, we let the default behavior proceed.
        if hitView != self {
            return hitView
        }

        // 3. At this point, we know the touch is on this view's background.
        // We need to check if there is an interactive view directly *underneath* this point.
        // To do this, we iterate through all sibling views that are behind this one.
        guard let superview = self.superview, let myIndex = superview.subviews.firstIndex(of: self) else {
            // If we have no superview or we are not in its hierarchy, we can't check siblings.
            // In this case, we just handle the touch ourselves.
            return self
        }

        // Iterate backwards through the subviews from the one right behind this view.
        for i in (0..<myIndex).reversed() {
            let siblingView = superview.subviews[i]
            // Convert the touch point to the sibling's coordinate system.
            let convertedPoint = self.convert(point, to: siblingView)
            // Ask the sibling if it wants to handle the touch.
            if let underlyingHitView = siblingView.hitTest(convertedPoint, with: event) {
                // If the sibling returns a view, it means it wants the touch.
                // In this case, we should "pass through" the touch by returning nil.
                return nil
            }
        }

        // 4. If we iterated through all the views underneath and none of them
        // wanted the touch, it's finally our turn. We return `self` to handle it.
        return self
    }

    // Convenience method to add a tap gesture recognizer.
    func addTapGesture(action: @escaping () -> Void) {
        self.onTap = action
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.addGestureRecognizer(tapGesture)
    }

    @objc private func handleTap() {
        // Execute the onTap closure when the tap is recognized.
        onTap?()
    }
}
