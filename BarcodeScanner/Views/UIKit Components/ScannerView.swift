//
//  ScannerView.swift
//  BarcodeScanner
//
//  Created by Pulkit Dhirana on 6/23/25.
//

import SwiftUI

struct ScannerView: UIViewControllerRepresentable {
    
    @Binding var scannedCode: String
    @Binding var alertItem: AlertItem?
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(scannedView: self)
    }
    
    
    func makeUIViewController(context: Context) -> ScannerVC {
        ScannerVC(scannerVCDelegate: context.coordinator)
    }
    
    func updateUIViewController(_ uiViewController: ScannerVC, context: Context) { }
    
    // Coordinator listens to ScannerVCDelegate (UI View Controller)
    
    final class Coordinator: NSObject, ScannerVCDelegate {
        
        private let scannedView: ScannerView
        
        init(scannedView: ScannerView) {
            self.scannedView = scannedView
        }
        
        func didFind(barcode: String) {
            scannedView.scannedCode = barcode
        }
        
        func didSurface(error: CameraError) {
            switch error {
            case .invalidDeviceInput:
                scannedView.alertItem = AlertContext.invalidDeviceInput
            case .invalidScannedValue:
                scannedView.alertItem = AlertContext.invalidScannedType
            }
        }
        
        
    }
}

#Preview {
    ScannerView(scannedCode: .constant("123456"), alertItem: .constant(AlertItem(title: "", message: "", dismissButton: .default(Text("")))))
}
