//
//  BarcodeScannerCore.swift
//  BarcodeKit
//
//  Created by Miniu on 28/11/2019.
//  Copyright © 2019 KB. All rights reserved.
//

import AVFoundation

public protocol BarcodeScannerCore: ObservableObject {
    func startScanning()
    func stopScanning()
}
