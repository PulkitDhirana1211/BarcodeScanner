//
//  ContentView.swift
//  BarcodeScanner
//
//  Created by Pulkit Dhirana on 6/21/25.
//

import SwiftUI

struct BarcodeScannerView: View {
    
    @StateObject private var viewModel = BarcodeScannerViewModel()
    
    var body: some View {
        NavigationView {
            if #available(iOS 17.0, *) {
                VStack {
                    ScannerView(scannedCode: $viewModel.scannedCode, alertItem: $viewModel.alertItem, shouldReset: $viewModel.shouldResetScanner)
                        .frame(maxWidth: .infinity, maxHeight: 300)
                    
                    Spacer()
                        .frame(height: 60)
                    
                    Label("Scanned Barcode:", systemImage: "barcode.viewfinder")
                        .font(.title)
                    
                    Text(viewModel.statusText)
                        .bold()
                        .font(.largeTitle)
                        .foregroundStyle(viewModel.statusTextColor)
                        .padding()
                }
                .navigationTitle("Barcode Scanner")
                .alert(item: $viewModel.alertItem) { alertItem in
                    Alert(title: Text(alertItem.title),
                          message: Text(alertItem.message),
                          dismissButton: alertItem.dismissButton)
                }
                .onChange(of: viewModel.scannedCode) { oldValue, newValue in
                    if !newValue.isEmpty {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            openProductInBrowser(barcode: newValue)
                            // Reset scanner after opening browser
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                viewModel.resetScanner()
                            }
                        }
                    }
                }
            } else {
                // Fallback on earlier versions
            }
        }
        
    }
    
    private func openProductInBrowser(barcode: String) {
        let productURL = "https://www.upcitemdb.com/upc/\(barcode)"
        
        if let url = URL(string: productURL) {
            UIApplication.shared.open(url)
        }
    }
}

#Preview {
    BarcodeScannerView()
}
