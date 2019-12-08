//
//  BarcodeScannerStatus.swift
//  BarcodeKit
//
//  Created by Miniu on 28/11/2019.
//  Copyright © 2019 KB. All rights reserved.
//

import AVFoundation

/// Current status of Barcode Scanner components.
public final class BarcodeScannerStatus: ObservableObject {
    /// Indicating whether scanner is up and running.
    @Published public private(set) var isScanning = false
    
    /// Indicating wheter camera is broadcasting video.
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
            DispatchQueue.main.async {
                self?.isScanning = value.newValue ?? false
            }
        }

        previewObserver = preview.observe(\.isPreviewing, options: .new) { [weak self] (_, value) in
            DispatchQueue.main.async {
                self?.isPreviewing = value.newValue ?? false
            }
        }
    }
    
    deinit {
        sessionObserver?.invalidate()
        previewObserver?.invalidate()
    }
}
