//
//  BarcodeScannerRawMetadataOutput.swift
//  BarcodeKit
//
//  Created by Miniu on 28/11/2019.
//  Copyright © 2019 KB. All rights reserved.
//

import Foundation
import AVFoundation

class CaptureMetadataOutput: NSObject {
    var metadata: (([AVMetadataObject]) -> Void)?
}

extension CaptureMetadataOutput: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        guard !metadataObjects.isEmpty else {
            return
        }
        
        metadata?(metadataObjects)
    }
}
