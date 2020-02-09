//
//  UISegmentedControlExtensions.swift
//  Helpers
//
//  Created by Ivan Cabezon on 08/02/2020.
//  Copyright © 2020 Ivan Cabezon. All rights reserved.
//

import UIKit

public extension UISegmentedControl {
	func removeLast(animated: Bool = false) {
		let lastIndex = numberOfSegments - 1
		removeSegment(at: lastIndex, animated: animated)
	}
}
