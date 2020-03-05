//
//  File.swift
//  
//
//  Created by Ivan Cabezon on 05/03/2020.
//

import Foundation

public extension DateFormatter {
	var medium: DateFormatter {
		let dateFormatter = DateFormatter()
		dateFormatter.dateStyle = .medium
		dateFormatter.timeStyle = .medium
		return dateFormatter
	}
}

