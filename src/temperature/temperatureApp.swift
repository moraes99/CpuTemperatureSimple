//
//  temperatureApp.swift
//  temperature
//
//  Created by Rafael Moraes on 01/04/23.
//

import SwiftUI
import Cocoa

@main
struct temperatureApp: App {
    
    @ObservedObject var viewModel = temperatureAppViewModel()
    
    var body: some Scene {
        MenuBarExtra {
            VStack {
                Button {
                    viewModel.toggleIcon()
                } label: {
                    Text(viewModel.isIcon ? "icon.hide".localized : "icon.show".localized)
                }
                Button {
                    viewModel.toggleScale()
                } label: {
                    Text("changeScale".localized)
                }
                Button {
                    viewModel.toggleFormat()
                } label: {
                    Text("numberFormat".localized)
                }
                Divider()
                Button {
                    NSApplication.shared.terminate(nil)
                } label: {
                    Text("exit".localized)
                }
            }
            
        } label: {
            VStack {
                if viewModel.isIcon {
                    Image(systemName: "cpu.fill")
                }
                Text(viewModel.tempereture)
            }
            .onAppear {
                Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                    self.viewModel.getTemperature()
                }
            }
        }
    }
}
