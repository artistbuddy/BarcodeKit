//
//  BarcodeScannerPreview.swift
//  BarcodeKit
//
//  Created by Miniu on 28/11/2019.
//  Copyright © 2019 KB. All rights reserved.
//

import UIKit

public protocol BarcodeScannerPreview: ObservableObject {
    var videoOutput: UIView { get }
}
