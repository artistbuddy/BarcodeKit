//
//  BarcodeScannerPreview.swift
//  BarcodeKit
//
//  Created by Miniu on 28/11/2019.
//  Copyright © 2019 KB. All rights reserved.
//

import UIKit

/// Scanner's camera video preview.
public final class BarcodeScannerPreview: ObservableObject {
    /// Camera viewfinder output.
    ///
    /// Presents user camera preview when scanning is on.
    public var videoOutput: CaptureVideoPreviewView { videoPreview }
    private var videoPreview: CaptureVideoPreviewView
    
    init(videoPreview: CaptureVideoPreviewView) {
        self.videoPreview = videoPreview
    }
}
