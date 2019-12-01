//
//  BarcodeScannerPreview.swift
//  BarcodeKit
//
//  Created by Miniu on 28/11/2019.
//  Copyright © 2019 KB. All rights reserved.
//

import UIKit

public final class BarcodeScannerPreview: ObservableObject {
    public var videoOutput: UIView { videoPreview }
    private var videoPreview: CaptureVideoPreviewView
    
    init(videoPreview: CaptureVideoPreviewView) {
        self.videoPreview = videoPreview
    }
}
