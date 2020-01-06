//
//  BarcodeScannerCamera.swift
//  BarcodeKit
//
//  Created by Miniu on 02/12/2019.
//  Copyright © 2019 KB. All rights reserved.
//

import SwiftUI

public enum BarcodeScannerState {
    /// Barcode Scanner is properly configured and ready to start scanning.
    case ready
    
    /// Barcode Scanner is running and actively scanning.
    case scanning
    
    /// Barcode Scanner occured some error.
    case failure
}

/// Shows given camera preview otherwise no camera symbol with message.
public struct BarcodeScannerCamera: View {
    let state: BarcodeScannerState
    let preview: UIView
    let message: String?
    
    /// Initializes view for previewing video from scanner camera.
    ///
    /// - Parameters:
    ///     - state: Indicates scanner current status.
    ///     - preview: View that contains layer of video output from camera.
    ///     - message: Text for user if for some reason preview isn't available.
    public init(state: BarcodeScannerState, preview: UIView, message: String? = nil) {
        self.state = state
        self.preview = preview
        self.message = message
    }
    
    public var body: some View {
        switch state {
        case .scanning:
            return AnyView(CameraPreview(videoOutput: preview))
            
        case .failure, .ready:
            return AnyView(CameraFailure(reason: message ?? ""))
        }
    }
}
