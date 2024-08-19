//
//  MissionDetailView.swift
//  MoonShot
//
//  Created by Akshat Gandhi on 20/08/24.
//

import SwiftUI

struct MissionDetailView: View {
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
    let missions: Mission
    let crew: [CrewMember]
    
    
    var body: some View {
        ScrollView {
            VStack {
                Image(missions.image)
                    .resizable()
                    .scaledToFit()
                    .containerRelativeFrame(.horizontal) { width, axis in
                        width * 0.6
                    }
                if let date = missions.launchDate {
                    Label(date.formatted(date: .complete, time: .omitted), systemImage: "calendar")
                }
                VStack(alignment: .leading) {
                    CustomDivider()
                    
                    Text("Mission Highlights")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/.bold())
                        .padding(.bottom, 5)
                    
                    Text(missions.description)
                    
                    CustomDivider()
                    
                    Text("Crew")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/.bold())
                        .padding(.bottom, 5)
                }
                .padding(.horizontal)
                
                CrewRoster(crew: crew)
            }
            .padding(.bottom)
        }
        .navigationTitle(missions.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
    
    init(missions: Mission, astronauts: [String: Astronaut]) {
        self.missions = missions
        self.crew = missions.crew.map({ member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Something went wrong")
            }
        })
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode(file: "missions.json")
    let astronuts: [String: Astronaut] = Bundle.main.decode(file: "astronauts.json")
    return MissionDetailView(missions: missions[1], astronauts: astronuts)
        .preferredColorScheme(.dark)
}
