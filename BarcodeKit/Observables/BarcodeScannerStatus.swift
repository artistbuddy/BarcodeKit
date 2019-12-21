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
    
    /// Indicating wheter some error occured.
    ///
    /// For error details check `errors` property.
    @Published public private(set) var errorOccured = false
    
    /// Contains error value if any.
    @Published public private(set) var errors = [BarcodeScannerConfiguratorError]()
    
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
    
    func errorOccured(_ error: BarcodeScannerConfiguratorError) {
        errors.append(error)
    }
    
    func errorOccured(_ errors: [BarcodeScannerConfiguratorError]) {
        self.errors.append(contentsOf: errors)
    }
}
