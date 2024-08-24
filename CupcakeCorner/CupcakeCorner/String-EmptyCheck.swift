//
//  String-EmptyCheck.swift
//  CupcakeCorner
//
//  Created by Akshat Gandhi on 24/08/24.
//

import Foundation

extension String {
    var isEmptyCheck: Bool {
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
