//
//  BarcodeScannerConfigurator.swift
//  BarcodeKit
//
//  Created by Miniu on 29/11/2019.
//  Copyright © 2019 KB. All rights reserved.
//

import AVFoundation

public class BarcodeScannerConfigurator {
    private(set) lazy var session = AVCaptureSession()
    private(set) var input: AVCaptureDeviceInput?
    private(set) lazy var output: AVCaptureMetadataOutput = {
        let output = AVCaptureMetadataOutput()
        output.setMetadataObjectsDelegate(self.metadata, queue: .global(qos: .userInitiated))
        
        return output
    }()
    private(set) lazy var metadata = CaptureMetadataOutput()
    private(set) var preview = CaptureVideoPreviewView()
    private(set) lazy var errors: [BarcodeScannerConfiguratorError] = []
    
    public func attachCamera(_ camera: BarcodeScannerCameraType) -> BarcodeScannerConfigurator {
        if let device = makeCaptureDevice(for: camera), let input = makeCaptureInput(device: device) {
            attachToSession(session, input: input)
        }
        
        return self
    }
    
    public func addDetectors(_ detectors: [BarcodeScannerDetector]) -> BarcodeScannerConfigurator {
        output.metadataObjectTypes = detectors.map{ $0.metadataObjectType }
        
        return self
    }
    
    public func createPreview() -> BarcodeScannerConfigurator {
        preview.videoLayer.session = session
        
        return self
    }
    
    public func buildScanner() -> Result<BarcodeScanner, BarcodeScannerConfiguratorError> {
        if let error = errors.first {
            return .failure(error)
        }
        
        let scanner = BarcodeScanner(session: session, metadataOutput: metadata, preview: preview)
        
        return .success(scanner)
    }
    
    
}

// MARK:- Set of standard configurations
public extension BarcodeScannerConfigurator {
    static let `default`: Result<BarcodeScanner, BarcodeScannerConfiguratorError> = {
        BarcodeScannerConfigurator()
            .attachCamera(.builtInWideAngle)
            .addDetectors(BarcodeScannerDetector.allCases)
            .createPreview()
            .buildScanner()
    }()
}

// MARK:- Convenience private methods
private extension BarcodeScannerConfigurator {
    func makeCaptureDevice(for camera: BarcodeScannerCameraType) -> AVCaptureDevice? {
        switch camera {
        case .builtInWideAngle:
            guard let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
                errors.append(.builtInCameraNotAvailable)
                return nil
            }
            
            return device
        }
    }
    
    func makeCaptureInput(device: AVCaptureDevice) -> AVCaptureDeviceInput? {
        do {
            let input = try AVCaptureDeviceInput(device: device)
            return input
        } catch let error {
            errors.append(.captureDeviceError(error))
            return nil
        }
    }
    
    func attachToSession(_ session: AVCaptureSession, input: AVCaptureInput) {
        if session.canAddInput(input) {
            session.addInput(input)
        } else {
            errors.append(.cannotAttachInput)
        }
    }
    
    func attachToSession(_ session: AVCaptureSession, output: AVCaptureOutput) {
        if session.canAddOutput(output) {
            session.addOutput(output)
        } else {
            errors.append(.cannotAttachOutput)
        }
    }
}

fileprivate extension BarcodeScannerDetector {
    var metadataObjectType: AVMetadataObject.ObjectType {
        switch self {
        case .ean16: return .ean13
        case .ean8: return .ean8
        case .upce: return .upce
        }
    }
}
