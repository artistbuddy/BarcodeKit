//
//  BarcodeScannerStatus.swift
//  BarcodeKit
//
//  Created by Miniu on 28/11/2019.
//  Copyright © 2019 KB. All rights reserved.
//

import AVFoundation

public final class BarcodeScannerStatus: ObservableObject {
    @Published public private(set) var isScanning = false
    @Published public private(set) var isPreviewing = false
    
    private let session: AVCaptureSession
    private let preview: AVCaptureVideoPreviewLayer
    
    init(session: AVCaptureSession, preview: AVCaptureVideoPreviewLayer) {
        self.session = session
        self.preview = preview
        
        setupStatusObservers()
    }
    
    private var sessionObserver: NSKeyValueObservation?
    private var previewObserver: NSKeyValueObservation?
    
    private func setupStatusObservers() {
        sessionObserver = session.observe(\.isRunning, options: .new) { [weak self] (_, value) in
            self?.isScanning = value.newValue ?? false
        }

        previewObserver = preview.observe(\.isPreviewing, options: .new) { [weak self] (_, value) in
            self?.isPreviewing = value.newValue ?? false
        }
    }
    
    deinit {
        sessionObserver?.invalidate()
        previewObserver?.invalidate()
    }
}
