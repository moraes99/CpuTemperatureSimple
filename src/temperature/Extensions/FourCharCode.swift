//
//  FourCharCode.swift
//  Temperature Simple
//
//  Created by Rafael Moraes on 03/04/23.
//

import IOKit

extension FourCharCode {
    init(fromString value: StringLiteralType) {
        precondition(value.utf8.count == 4)
        self = value.utf8.reduce(0) { $0 << 8 + FourCharCode($1) }
    }
}
