//
//  BarcodeScanner.swift
//  BarcodeKit
//
//  Created by Miniu on 28/11/2019.
//  Copyright © 2019 KB. All rights reserved.
//

import UIKit
import AVFoundation

class BarcodeScanner {
    private let session: AVCaptureSession
    private let previewView: CaptureVideoPreviewView
    private let metadataOutput: ScannerMetadataOutput
    private lazy var data: [BarcodeData] = []
    
    init(session: AVCaptureSession, metadataOutput: ScannerMetadataOutput, preview: CaptureVideoPreviewView) {
        self.session = session
        self.metadataOutput = metadataOutput
        self.previewView = preview
    }
    
    
    private func processMetadata(_ objects: [AVMetadataObject]) {
        guard let metadataObject = objects.first else {
            return
        }

        guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else {
           return
        }

        guard let stringValue = readableObject.stringValue else {
           return
        }
        
        let barcode = BarcodeData(value: stringValue)
        
        data.append(barcode)
    }
}

extension BarcodeScanner: BarcodeScannerCore {
    func startScanning() {
        metadataOutput.metadata = processMetadata
        
        if !session.isRunning {
            session.startRunning()
        }
    }
    
    func stopScanning() {
        metadataOutput.metadata = nil
        
        if session.isRunning {
            session.startRunning()
        }
    }
}

extension BarcodeScanner: BarcodeScannerStatus {
    var isScanning: Bool {
        session.isRunning
    }
    
    var isPreviewing: Bool {
        previewLayer.isPreviewing
    }
    
    private var previewLayer: AVCaptureVideoPreviewLayer {
        previewView.videoLayer
    }
}

extension BarcodeScanner: BarcodeScannerOutput {
    var barcodes: [BarcodeData] {
        return data
    }
}

extension BarcodeScanner: BarcodeScannerPreview {
    var videoOutput: UIView {
        previewView
    }
}
