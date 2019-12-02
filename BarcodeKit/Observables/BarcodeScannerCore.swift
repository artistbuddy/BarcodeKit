//
//  BarcodeScannerCore.swift
//  BarcodeKit
//
//  Created by Miniu on 28/11/2019.
//  Copyright © 2019 KB. All rights reserved.
//

import AVFoundation

/// Core functions of Barcode Scanner.
///
/// Use for starting or stopping scanner.
public final class BarcodeScannerCore: ObservableObject {
    private let session: AVCaptureSession
    private let output: BarcodeScannerOutput
    
    init(session: AVCaptureSession, output: BarcodeScannerOutput) {
        self.session = session
        self.output = output
    }
    
    /// Begin scanning for barcodes.
    ///
    /// It enables camera preview and clear output.
    public func startScanning() {
        if !session.isRunning {
            session.startRunning()
            output.clearBarcodes()
        }
    }
    
    /// Finish scanning for barcodes.
    ///
    /// It disables camera preview.
    public func stopScanning() {
        if session.isRunning {
            session.stopRunning()
        }
    }
}
