//
//  CaptureVideoPreviewView.swift
//  BarcodeKit
//
//  Created by Miniu on 28/11/2019.
//  Copyright © 2019 KB. All rights reserved.
//

import UIKit
import AVFoundation

class CaptureVideoPreviewView: UIView {
    override class var layerClass: AnyClass {
        return AVCaptureVideoPreviewLayer.self
    }
    
    var videoLayer: AVCaptureVideoPreviewLayer {
        return layer as! AVCaptureVideoPreviewLayer
    }
}
