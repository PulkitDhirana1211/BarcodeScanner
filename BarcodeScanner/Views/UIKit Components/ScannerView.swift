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
    @Binding var shouldReset: Bool
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(scannedView: self)
    }
    
    
    func makeUIViewController(context: Context) -> ScannerVC {
        ScannerVC(scannerVCDelegate: context.coordinator)
    }
    
    func updateUIViewController(_ uiViewController: ScannerVC, context: Context) {
        if shouldReset {
            uiViewController.resetScanner()
            DispatchQueue.main.async {
                shouldReset = false
            }
        }
    }
    
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
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
                guard let self = self else {
                    return
                }
                
                switch error {
                case .invalidDeviceInput:
                    self.scannedView.alertItem = AlertContext.invalidDeviceInput
                    
                case .invalidScannedValue:
                    self.scannedView.alertItem = AlertContext.invalidScannedType
                }
            }
        }
        
        func resetScanner() {
            // This will be handled by the UIViewControllerRepresentable
        }
        
        
    }
}

#Preview {
    ScannerView(scannedCode: .constant("123456"), alertItem: .constant(AlertItem(title: "", message: "", dismissButton: .default(Text("")))), shouldReset: .constant(false))
}
