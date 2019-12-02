//
//  BarcodeScannerCamera.swift
//  BarcodeKit
//
//  Created by Miniu on 02/12/2019.
//  Copyright © 2019 KB. All rights reserved.
//

import SwiftUI

/// Shows camera video output.
///
/// If `BarcodeScanner` is scanning it shows live camera preview otherwise no camera symbol
///
/// - Requires: Inject `BarcodeScannerStatus` and `BarcodeScannerPreview`.
/// ````
/// var scanner = BarcodeScanner()
///
/// var body: some View {
///     BarcodeScannerCammera()
///         .environmentObject(scanner.status)
///         .environmentObject(scanner.preview)
/// }
/// ````
public struct BarcodeScannerCamera: View {
    @EnvironmentObject private var status: BarcodeScannerStatus
    
    public init() { }
    
    public var body: some View {
        Group {
            if status.isPreviewing {
                CameraPreview()
            } else {
                CameraFailure(reason: "")
            }
        }
    }
}
