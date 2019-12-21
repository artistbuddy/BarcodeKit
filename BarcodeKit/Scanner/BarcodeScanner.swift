//
//  BarcodeScanner.swift
//  BarcodeKit
//
//  Created by Miniu on 28/11/2019.
//  Copyright © 2019 KB. All rights reserved.
//

import UIKit
import AVFoundation

/// Contains components of barcode scanner.
public final class BarcodeScanner {
    public let core: BarcodeScannerCore
    public let preview: BarcodeScannerPreview
    public let status: BarcodeScannerStatus
    public let output: BarcodeScannerOutput
    
    init(session: AVCaptureSession, captureMetadata: CaptureMetadataOutput, previewView: CaptureVideoPreviewView) {
        output = BarcodeScannerOutput(captureMetadata: captureMetadata)
        core = BarcodeScannerCore(session: session, output: output)
        preview = BarcodeScannerPreview(videoPreview: previewView)
        status = BarcodeScannerStatus(session: session, preview: previewView.videoLayer)
    }
    
    /// Build scanner with given configuration.
    ///
    /// It calls `buildScanner()` method on configurator.
    public convenience init(config configurator: BarcodeScannerConfigurator) {
        _ = configurator.buildScanner()
        
        self.init(session: configurator.session, captureMetadata: configurator.metadata, previewView: configurator.preview)
        
        if !configurator.errors.isEmpty {
            status.errorOccured(configurator.errors)
        }
    }
}


