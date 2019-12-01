//
//  BarcodeScannerView.swift
//  BarcodeKit
//
//  Created by Miniu on 28/11/2019.
//  Copyright © 2019 KB. All rights reserved.
//

import UIKit
import AVFoundation

public final class BarcodeScanner {
    public let core: BarcodeScannerCore
    public let preview: BarcodeScannerPreview
    public let status: BarcodeScannerStatus
    public let output: BarcodeScannerOutput
    
    init(session: AVCaptureSession, captureMetadata: CaptureMetadataOutput, previewView: CaptureVideoPreviewView) {
        core = BarcodeScannerCore(session: session)
        preview = BarcodeScannerPreview(videoPreview: previewView)
        status = BarcodeScannerStatus(session: session, preview: previewView.videoLayer)
        output = BarcodeScannerOutput(captureMetadata: captureMetadata)
    }
}


