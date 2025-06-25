//
//  Alert.swift
//  BarcodeScanner
//
//  Created by Pulkit Dhirana on 6/23/25.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title: String
    let message: String
    let dismissButton: Alert.Button
}

struct AlertContext {
    static let invalidDeviceInput = AlertItem(title: "Invalid Device Input",
                                              message: "Something is wrong with the camera. We are unable to capture the input.",
                                              dismissButton: .default(Text("OK")))
    
    static let invalidScannedType = AlertItem(title: "Invalid Scanned Value",
                                              message: "The scanned value is not valid. This app scans EAN-8 and EAN-13.",
                                              dismissButton: .default(Text("OK")))

}
