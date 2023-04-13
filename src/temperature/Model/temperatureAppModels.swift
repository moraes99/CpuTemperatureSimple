//
//  temperatureAppModels.swift
//  Temperature Simple
//
//  Created by Rafael Moraes on 03/04/23.
//

import IOKit

struct KeyInfo {
    var dataSize: IOByteCount = 0
    var dataType: UInt32 = 0
    var dataAttributes: UInt8 = 0
}

struct InOutStruct {
    var key: FourCharCode = 0
    var dummy: DummyBytes = (0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    var keyInfo = KeyInfo()
    var padding: UInt16 = 0
    var result: UInt8 = 0
    var status: UInt8 = 0
    var data8: UInt8 = 0
    var data32: UInt32 = 0
    var bytes: DataBytes = (
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0
    )
}

typealias DummyBytes = (UInt8, UInt8, UInt8, UInt8, UInt16, UInt16, UInt16, UInt32, UInt32, UInt32)

typealias DataBytes = (
    UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8,
    UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8
)
