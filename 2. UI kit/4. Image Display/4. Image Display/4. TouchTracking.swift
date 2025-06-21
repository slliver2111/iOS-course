import UIKit

class TouchTrackingView: UIView {
    let name: String

    init(name: String, frame: CGRect, color: UIColor) {
        self.name = name
        super.init(frame: frame)
        backgroundColor = color
        isUserInteractionEnabled = true
    }

    required init?(coder: NSCoder) { fatalError() }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("✅ \(name) received touchesBegan")
        printResponderChain()
    }

    private func printResponderChain() {
        var responder: UIResponder? = self
        print("🔗 Responder chain:")
        while let next = responder?.next {
            print("→ \(type(of: next))")
            responder = next
        }
    }
}

