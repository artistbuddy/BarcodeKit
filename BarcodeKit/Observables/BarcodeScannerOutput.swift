//
//  BarcodeScannerOutput.swift
//  BarcodeKit
//
//  Created by Miniu on 28/11/2019.
//  Copyright © 2019 KB. All rights reserved.
//

import Foundation

public protocol BarcodeScannerOutput: ObservableObject {
    var barcodes: [BarcodeData] { get }
}
