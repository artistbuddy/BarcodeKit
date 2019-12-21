//
//  BarcodeKit.swift
//  BarcodeKit
//
//  Created by Miniu on 21/12/2019.
//  Copyright © 2019 KB. All rights reserved.
//

import SwiftUI

struct BarcodeScannerEnvironment: ViewModifier {
    let barcodeScanner: BarcodeScanner
    
    func body(content: Content) -> some View {
        content
            .environmentObject(barcodeScanner.core)
            .environmentObject(barcodeScanner.output)
            .environmentObject(barcodeScanner.preview)
            .environmentObject(barcodeScanner.status)
    }
}

public extension View {
    /// Injects Barcode Scanner environments.
    func barcodeKit(_ scanner: BarcodeScanner) -> some View {
        self.modifier(BarcodeScannerEnvironment(barcodeScanner: scanner))
    }
}
