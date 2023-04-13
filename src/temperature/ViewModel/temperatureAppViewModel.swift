//
//  temperatureAppViewModel.swift
//  temperature
//
//  Created by Rafael Moraes on 02/04/23.
//

import Foundation
import Cocoa
import IOKit

final class temperatureAppViewModel: ObservableObject {
    
    private let isCelsiusKey = "isCelsius"
    private let isDecimalKey = "isDecimal"
    private let isIconKey = "isIcon"
    private let defaults = UserDefaults.standard
    
    @Published var tempereture: String = ""
    @Published var isCelsius: Bool
    @Published var isDecimal: Bool
    @Published var isIcon: Bool
    
    init() {
        
        if defaults.object(forKey: isIconKey) == nil {
            defaults.set(true, forKey: isIconKey)
        }
        
        if defaults.object(forKey: isCelsiusKey) == nil {
            defaults.set(true, forKey: isCelsiusKey)
        }
        
        if defaults.object(forKey: isDecimalKey) == nil {
            defaults.set(false, forKey: isDecimalKey)
        }
        
        isIcon = defaults.bool(forKey: isIconKey)
        isCelsius = defaults.bool(forKey: isCelsiusKey)
        isDecimal = defaults.bool(forKey: isDecimalKey)
    }
    
    //MARK: - Funcs
    public func toggleIcon() {
        isIcon.toggle()
        defaults.set(isIcon, forKey: isIconKey)
    }
    
    public func toggleScale() {
        isCelsius.toggle()
        defaults.set(isCelsius, forKey: isCelsiusKey)
    }
    
    public func toggleFormat() {
        isDecimal.toggle()
        defaults.set(isDecimal, forKey: isDecimalKey)
    }
    
    public func getTemperature() {
        isCelsius ? getCelsius() : getFahrenheit()
    }
    
    private func getFahrenheit() {
        var value = getCPUTemperature()
        let format = isDecimal ? "%.0f°F" : "%.01f°F"
        value = value * 9 / 5 + 32
        tempereture = String(format: format, value)
    }
    
    private func getCelsius() {
        let value = getCPUTemperature()
        let format = isDecimal ? "%.0f°C" : "%.01f°C"
        tempereture = String(format: format, value)
    }
    
    private func getCPUTemperature() -> Double {
        var conn:  io_connect_t = 0
        var result: kern_return_t = 0

        defer {
            if conn != 0 {
                IOServiceClose(conn)
            }
        }

        // Open Connection
        guard let matching = IOServiceMatching("AppleSMC") else { return 0 }
        let service = IOServiceGetMatchingService(kIOMainPortDefault, matching)
        if service == MACH_PORT_NULL { return 0 }
        result = IOServiceOpen(service, mach_task_self_, 0, &conn)
        IOObjectRelease(service)
        guard result == kIOReturnSuccess else { return 0 }

        // Read CPU Temperature
        var inputStruct = InOutStruct()
        inputStruct.key = FourCharCode(fromString: "TC0P")
        inputStruct.keyInfo.dataSize = 2
        inputStruct.data8 = 5

        var outputStruct = InOutStruct()
        let inputSize = MemoryLayout<InOutStruct>.stride
        var outputSize = MemoryLayout<InOutStruct>.stride

        result = IOConnectCallStructMethod(conn, UInt32(2), &inputStruct, inputSize, &outputStruct, &outputSize)
        guard result == kIOReturnSuccess, outputStruct.result == 0 else { return 0 }

        // Formatting the Value of Temperature
        return Double(256 * Int(outputStruct.bytes.0) + Int(outputStruct.bytes.1)) / 256.0
    }
}
