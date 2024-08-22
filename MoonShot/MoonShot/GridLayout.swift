//
//  GridLayout.swift
//  MoonShot
//
//  Created by Akshat Gandhi on 20/08/24.
//

import SwiftUI

struct GridLayout: View {
    let astronuts: [String: Astronaut]
    let missions: [Mission]
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, content: {
                ForEach(missions) { mission in
                    NavigationLink(value: mission) {
                        VStack {
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 100)
                            VStack {
                                Text(mission.displayName)
                                    .font(.headline)
                                    .foregroundStyle(.white)
                                Text(mission.formattedLaunchDate)
                                    .font(.caption)
                                    .foregroundStyle(.white.opacity(0.5))
                            }
                            .padding(.vertical)
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                            .background(.lightBackground)
                        }
                        .clipShape(.rect(cornerRadius: 10))
                        .overlay {
                            RoundedRectangle(cornerRadius: 10.0)
                                .stroke(.lightBackground)
                        }
                        .padding()
                    }
                }
            })
            .padding([.horizontal, .bottom])
        }
        .transition(.scale.animation(.easeInOut.delay(1.0)))
    }
}

#Preview {
    let astronuts: [String: Astronaut] = Bundle.main.decode(file: "astronauts.json")
    let missions: [Mission] = Bundle.main.decode(file: "missions.json")
    return GridLayout(astronuts: astronuts, missions: missions)
        .preferredColorScheme(.dark)
}
