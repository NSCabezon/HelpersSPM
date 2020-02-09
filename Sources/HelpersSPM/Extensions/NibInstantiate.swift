//
//  File.swift
//  
//
//  Created by Ivan Cabezon on 09/02/2020.
//

import UIKit

public protocol NibInstantiate {
	static var nibName: String { get }
}

extension NibInstantiate {
	public static var nibName: String {
		return String(describing: self)
	}
}

public extension NibInstantiate where Self: UIView {
	static func initFromNib() -> Self? {
		return UINib(nibName: nibName, bundle: Bundle(for: self)).instantiate(withOwner: self, options: nil)[0] as? Self
	}
}

public extension NibInstantiate where Self: UIViewController {
	static func initFromNib() -> Self? {
		return Self(nibName: nibName, bundle: Bundle(for: self))
	}
}
