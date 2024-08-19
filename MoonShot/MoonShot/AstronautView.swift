//
//  AstronautView.swift
//  MoonShot
//
//  Created by Akshat Gandhi on 20/08/24.
//

import SwiftUI

struct AstronautView: View {
    let astronut: Astronaut
    
    var body: some View {
        ScrollView {
            VStack {
                Image(astronut.id)
                    .resizable()
                    .scaledToFit()
                
                Text(astronut.description)
                    .padding()
            }
        }
        .background(.darkBackground)
        .navigationTitle(astronut.name)
        
    }
}

#Preview {
    let astronuts: [String: Astronaut] = Bundle.main.decode(file: "astronauts.json")
    
    return AstronautView(astronut: astronuts["aldrin"]!)
        .preferredColorScheme(.dark)
}
