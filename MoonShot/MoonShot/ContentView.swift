//
//  ContentView.swift
//  MoonShot
//
//  Created by Akshat Gandhi on 19/08/24.
//

import SwiftUI

struct ContentView: View {
    let astronuts: [String: Astronaut] = Bundle.main.decode(file: "astronauts.json")
    let missions: [Mission] = Bundle.main.decode(file: "missions.json")
    
    @State private var isShowingGrid: Bool = false
    
    var body: some View {
        NavigationStack {
            Group {
                if isShowingGrid {
                    GridLayout(astronuts: astronuts, missions: missions)
                } else {
                    ListLayout(astronuts: astronuts, missions: missions)
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar {
                Button {
                    withAnimation(.spring) {
                        isShowingGrid.toggle()
                    }
                } label: {
                    Image(systemName: isShowingGrid ? "list.dash" : "rectangle.grid.2x2.fill")
                        .foregroundStyle(.white)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
