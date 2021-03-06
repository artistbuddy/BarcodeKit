//
//  CameraPreview.swift
//  BarcodeKit
//
//  Created by Miniu on 02/12/2019.
//  Copyright © 2019 KB. All rights reserved.
//

import SwiftUI

struct CameraPreview: UIViewRepresentable {
    @EnvironmentObject private var preview: BarcodeScannerPreview
    
    func makeUIView(context: UIViewRepresentableContext<CameraPreview>) -> UIView {
        preview.videoOutput.videoLayer.videoGravity = .resizeAspectFill
        // TODO: Detect device orientation
        //preview.videoOutput.videoLayer.connection?.videoOrientation = .portrait
        
        return preview.videoOutput
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<CameraPreview>) { }
}
