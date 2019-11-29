//
//  BarcodeScannerStatus.swift
//  BarcodeKit
//
//  Created by Miniu on 28/11/2019.
//  Copyright © 2019 KB. All rights reserved.
//

import Foundation

public protocol BarcodeScannerStatus: ObservableObject {
    var isScanning: Bool { get }
    var isPreviewing: Bool { get }
}
