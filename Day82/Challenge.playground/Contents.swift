import UIKit

extension UIView {
    func bounceOut(duration: TimeInterval) {
        UIView.animate(withDuration: duration) {
            self.transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
        }
    }
}

let view = UIView()

view.bounceOut(duration: 4)

extension Int {
    func times(closure: () -> Void) {
        for _ in 1...self {
            closure()
        }
    }
}

5.times {
    print("Hello!")
}

extension Array where Element: Comparable {
    mutating func remove(item: Element) {
        let index = firstIndex(of: item)
        
        if let index = index {
            self.remove(at: index)
        }
    }
}

var array = [1, 1, 2, 3]

array.remove(item: 1)
