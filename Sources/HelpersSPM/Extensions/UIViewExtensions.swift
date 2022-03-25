#if !os(macOS) && !os(watchOS)
import UIKit

public extension UIView {
	var xOrigin: CGFloat {
		get {
			return self.frame.origin.x
		}
		set {
			self.frame.origin.x = newValue
		}
	}
	
	var yOrigin: CGFloat {
		get {
			return self.frame.origin.y
		}
		set {
			self.frame.origin.y = newValue
		}
	}
	
	var height: CGFloat {
		get {
			return self.frame.size.height
		}
		set {
			self.frame.size.height = newValue
		}
	}
	
	var width: CGFloat {
		get {
			return self.frame.size.width
		}
		set {
			self.frame.size.width = newValue
		}
	}
	
	func edgesToSuperview() {
		edgesToSuperview(with: UIEdgeInsets.zero)
	}
	
	/// Adds constraints to this `UIView` instances `superview` object to make sure this always has the same size as the superview.
	/// Please note that this has no effect if its `superview` is `nil` – add this `UIView` instance as a subview before calling this.
	func edgesToSuperview(with edges: UIEdgeInsets) {
		guard let superview = self.superview else {
			print("Error! `superview` was nil – call `addSubview(view: UIView)` before calling `bindFrameToSuperviewBounds()` to fix this.")
			return
		}
		
		self.translatesAutoresizingMaskIntoConstraints = false
		self.topAnchor.constraint(equalTo: superview.topAnchor, constant: edges.top).isActive = true
		self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -edges.bottom).isActive = true
		self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: edges.left).isActive = true
		self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -edges.right).isActive = true
	}
	
	func alignToView(_ view: UIView) {
		addConstraintToView(view, attribute: .top, constant: 0)
		addConstraintToView(view, attribute: .bottom, constant: 0)
		addConstraintToView(view, attribute: .leading, constant: 0)
		addConstraintToView(view, attribute: .trailing, constant: 0)
	}
	
    private func addConstraintToView(_ view: UIView, attribute: NSLayoutConstraint.Attribute, constant: CGFloat) {
        addConstraint(NSLayoutConstraint(item: view,
										 attribute: attribute,
										 relatedBy: .equal,
										 toItem: self,
										 attribute: attribute,
										 multiplier: 1.0,
										 constant: constant))
    }
    
    func heightConstant(constant: CGFloat) {
        setConstraintInView(value: constant, attribute: .height)
    }
    
    func widthConstant(constant: CGFloat) {
        setConstraintInView(value: constant, attribute: .width)
    }
    
    private func setConstraintInView(value: CGFloat, attribute: NSLayoutConstraint.Attribute) {
        removeConstraint(attribute: attribute)
        NSLayoutConstraint(item: self, attribute: attribute, relatedBy: .equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: value).isActive = true
    }
    
    func centerY(constant: CGFloat = CGFloat(0), otherview: UIView) {
        setConstraintInView(value: constant, attribute: .centerY, otherView: otherview)
    }
    
    func centerX(constant: CGFloat = CGFloat(0), otherview: UIView) {
        setConstraintInView(value: constant, attribute: .centerX, otherView: otherview)
    }
    
    func topConstant(constant: CGFloat = CGFloat(0), otherview: UIView) {
        setConstraintInView(value: constant, attribute: .top, otherView: otherview)
    }
    
    func bottomConstant(constant: CGFloat = CGFloat(0), otherview: UIView) {
        setConstraintInView(value: constant, attribute: .bottom, otherView: otherview)
    }
    
    func removeConstraintOfView(inside contentView: UIView) {
        for constraint in contentView.constraints {
            if constraint.firstItem === self || constraint.secondItem === self {
                contentView.removeConstraint(constraint)
            }
        }
    }
    
    func removeConstraint(attribute: NSLayoutConstraint.Attribute) {
        constraints.forEach {
            if $0.firstAttribute == attribute {
                removeConstraint($0)
            }
        }
    }
    
    private func setConstraintInView(value: CGFloat, attribute: NSLayoutConstraint.Attribute, otherView: UIView) {
        removeConstraint(attribute: attribute)
        NSLayoutConstraint(item: self, attribute: attribute, relatedBy: .equal, toItem: otherView, attribute: attribute, multiplier: 1, constant: value).isActive = true
    }
}
#endif
