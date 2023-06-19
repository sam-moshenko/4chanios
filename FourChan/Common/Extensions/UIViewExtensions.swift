import SnapKit
import UIKit

extension UIView {
    func addSubview(_ view: UIView, _ makeConstraints: (ConstraintMaker) -> Void) {
        addSubview(view)
        view.snp.makeConstraints(makeConstraints)
    }
    
    func addSubviews(_ subviews: [UIView]) {
        subviews.forEach(addSubview)
    }
}
