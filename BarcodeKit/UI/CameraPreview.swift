//
//  CameraPreview.swift
//  BarcodeKit
//
//  Created by Miniu on 02/12/2019.
//  Copyright © 2019 KB. All rights reserved.
//

import SwiftUI

struct CameraPreview: UIViewRepresentable {
    let videoOutput: UIView
    
    func makeUIView(context: UIViewRepresentableContext<CameraPreview>) -> UIView {
        videoOutput
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<CameraPreview>) { }
}
