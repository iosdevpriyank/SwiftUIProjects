//
//  ImageLoadDemo.swift
//  CupcakeCorner
//
//  Created by Akshat Gandhi on 22/08/24.
//

import SwiftUI

struct ImageLoadDemo: View {
    var body: some View {
        AsyncImage(url: URL(string: "https://www.tooft.com/wp-content/uploads/2010/06/doodle_for_google_by_Bluerose1324.jpg")) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFit()
            } else if phase.error != nil {
                Text("Error loading image")
            } else {
                ProgressView()
            }
        }
        .frame(width: 400, height: 400)
    }
}

#Preview {
    ImageLoadDemo()
}
