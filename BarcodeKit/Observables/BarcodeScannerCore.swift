//
//  BarcodeScannerCore.swift
//  BarcodeKit
//
//  Created by Miniu on 28/11/2019.
//  Copyright © 2019 KB. All rights reserved.
//

import AVFoundation

public final class BarcodeScannerCore: ObservableObject {
    private let session: AVCaptureSession
    
    init(session: AVCaptureSession) {
        self.session = session
    }
    
    public func startScanning() {
        if !session.isRunning {
            session.startRunning()
        }
    }
    
    public func stopScanning() {
        if session.isRunning {
            session.stopRunning()
        }
    }
}
