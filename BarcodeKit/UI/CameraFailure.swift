//
//  CameraFailure.swift
//  BarcodeKit
//
//  Created by Miniu on 02/12/2019.
//  Copyright © 2019 KB. All rights reserved.
//

import SwiftUI

struct CameraFailure: View {
    private static let symbol = "video.slash"
    let reason: String
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Image(systemName: CameraFailure.symbol)
                    .font(.largeTitle)
                Text(reason)
                    .font(.body)
            }
            Spacer()
        }
    }
}

struct CameraFailure_Previews: PreviewProvider {
    static var previews: some View {
        CameraFailure(reason: "No preview available!")
    }
}
