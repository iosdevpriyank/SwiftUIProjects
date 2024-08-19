//
//  CustomDivider.swift
//  MoonShot
//
//  Created by Akshat Gandhi on 20/08/24.
//

import SwiftUI

struct CustomDivider: View {
    var body: some View {
        Rectangle()
            .frame(height: 2)
            .background(.lightBackground)
            .padding(.vertical)
    }
}

#Preview {
    CustomDivider()
        .preferredColorScheme(.dark)
}
