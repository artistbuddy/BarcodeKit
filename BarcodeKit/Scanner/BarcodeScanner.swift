//
//  BarcodeScanner.swift
//  BarcodeKit
//
//  Created by Miniu on 28/11/2019.
//  Copyright © 2019 KB. All rights reserved.
//

import UIKit
import AVFoundation

public class BarcodeScanner {
    private let session: AVCaptureSession
    private let previewView: CaptureVideoPreviewView
    private let metadataOutput: CaptureMetadataOutput
    private lazy var data: [BarcodeData] = []
    
    init(session: AVCaptureSession, metadataOutput: CaptureMetadataOutput, preview: CaptureVideoPreviewView) {
        self.session = session
        self.metadataOutput = metadataOutput
        self.previewView = preview
    }

    public convenience init(_ scanner: BarcodeScanner) {
        self.init(session: scanner.session, metadataOutput: scanner.metadataOutput, preview: scanner.previewView)
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
        
        guard let type = BarcodeType.init(metadaObject: readableObject.type) else {
            return
        }
        
        let barcode = BarcodeData(value: stringValue, type: type)
        
        data.append(barcode)
    }
}

// MARK:- BarcodeScannerCore
extension BarcodeScanner: BarcodeScannerCore {
    public func startScanning() {
        metadataOutput.metadata = processMetadata
        
        if !session.isRunning {
            session.startRunning()
        }
    }
    
    public func stopScanning() {
        metadataOutput.metadata = nil
        
        if session.isRunning {
            session.startRunning()
        }
    }
}

// MARK:- BarcodeScannerStatus
extension BarcodeScanner: BarcodeScannerStatus {
    public var isScanning: Bool {
        session.isRunning
    }
    
    public var isPreviewing: Bool {
        previewLayer.isPreviewing
    }
    
    private var previewLayer: AVCaptureVideoPreviewLayer {
        previewView.videoLayer
    }
}

// MARK:- BarcodeScannerOutput
extension BarcodeScanner: BarcodeScannerOutput {
    public var barcodes: [BarcodeData] {
        return data
    }
}

// MARK:- BarcodeScannerPreview
extension BarcodeScanner: BarcodeScannerPreview {
    public var videoOutput: UIView {
        previewView
    }
}

// MARK:- Convenience private methods
fileprivate extension BarcodeType {
    init?(metadaObject: AVMetadataObject.ObjectType) {
        switch metadaObject {
        case .upce: self = .upce
        case .ean8: self = .ean8
        case .ean13: self = .ean13
        default: return nil
        }
    }
}
