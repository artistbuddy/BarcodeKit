//
//  BarcodeScannerCamera.swift
//  BarcodeKit
//
//  Created by Miniu on 02/12/2019.
//  Copyright © 2019 KB. All rights reserved.
//

import SwiftUI

public enum BarcodeScannerState {
    case scanning(videoPreview: UIView)
    case failure(reason: String)
}

/// Shows given camera preview otherwise no camera symbol.
public struct BarcodeScannerCamera: View {
    @Binding public var state: BarcodeScannerState
    
    public init(state: Binding<BarcodeScannerState>) {
        _state = state
    }
    
    public var body: some View {
        switch state {
        case .scanning(let preview):
            return AnyView(CameraPreview(videoOutput: preview))
            
        case .failure(let reason):
            return AnyView(CameraFailure(reason: reason))
            
        }
    }
}
