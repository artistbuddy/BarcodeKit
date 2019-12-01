//
//  BarcodeScannerOutput.swift
//  BarcodeKit
//
//  Created by Miniu on 28/11/2019.
//  Copyright © 2019 KB. All rights reserved.
//

import AVFoundation

public final class BarcodeScannerOutput: ObservableObject {
    @Published public private(set) var barcodes = [BarcodeData]()
    
    public var mode: Mode = .unique {
        didSet {
            barcodes.removeAll()
        }
    }
    
    public enum Mode {
        case continuous
        case unique
    }
    
    private let capture: CaptureMetadataOutput
    
    init(captureMetadata: CaptureMetadataOutput) {
        capture = captureMetadata
        capture.metadata = processMetadata(_:)
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

        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else {
                return
            }
            
            switch strongSelf.mode {
            case .unique:
                if !strongSelf.barcodes.contains(barcode) {
                    strongSelf.barcodes.append(barcode)
                }
            case .continuous:
                strongSelf.barcodes.append(barcode)
            }
        }
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
