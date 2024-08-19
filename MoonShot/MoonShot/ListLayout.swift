//
//  ListLayout.swift
//  MoonShot
//
//  Created by Akshat Gandhi on 20/08/24.
//

import SwiftUI

struct ListLayout: View {
    let astronuts: [String: Astronaut]
    let missions: [Mission]
    
    var body: some View {
        List(missions) { mission in
            NavigationLink {
                MissionDetailView(missions: mission, astronauts: astronuts)
            } label: {
                HStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .padding()
                    
                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)
                        Text(mission.formattedLaunchDate)
                    }
                }
            }.transition(.opacity.animation(.linear.delay(1.0)))
        }
        
    }
}

#Preview {
    let astronuts: [String: Astronaut] = Bundle.main.decode(file: "astronauts.json")
    let missions: [Mission] = Bundle.main.decode(file: "missions.json")
    return ListLayout(astronuts: astronuts, missions: missions)
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
