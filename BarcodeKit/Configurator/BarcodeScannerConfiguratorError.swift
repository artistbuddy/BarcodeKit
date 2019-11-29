//
//  BarcodeScannerConfiguratorError.swift
//  BarcodeKit
//
//  Created by Miniu on 29/11/2019.
//  Copyright © 2019 KB. All rights reserved.
//

import Foundation

public enum BarcodeScannerConfiguratorError: Error {
    case builtInCameraNotAvailable
    case captureDeviceError(_ error: Error)
    case cannotAttachInput
    case cannotAttachOutput
}
