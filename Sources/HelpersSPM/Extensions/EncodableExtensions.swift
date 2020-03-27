//
//  File.swift
//  
//
//  Created by Ivan Cabezon on 27/03/2020.
//

import Foundation

public extension Encodable {
	var asJSON: JSON? {
		guard let data = try? JSONEncoder().encode(self) else { return nil }
		return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
	}
}
