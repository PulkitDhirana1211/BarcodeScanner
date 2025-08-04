//
//  BarcodeScannerViewModel.swift
//  BarcodeScanner
//
//  Created by Pulkit Dhirana on 6/23/25.
//

import SwiftUI

final class BarcodeScannerViewModel: ObservableObject {
    @Published var scannedCode: String = ""
    @Published var alertItem: AlertItem?
    @Published var shouldResetScanner: Bool = false
    
    var statusText: String {
        scannedCode.isEmpty ? "Not Yet Scanned" : scannedCode
    }
    
    var statusTextColor: Color {
        scannedCode.isEmpty ? .red : .green
    }
    
    func resetScanner() {
        scannedCode = ""
        shouldResetScanner = true
    }
}
