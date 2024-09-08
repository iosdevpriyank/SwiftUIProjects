//
//  UsersView.swift
//  SwiftDataProject
//
//  Created by Akshat Gandhi on 07/09/24.
//

import SwiftData
import SwiftUI

struct UsersView: View {
    @Query var users: [User]
    
    var body: some View {
        List(users) { user in
            NavigationLink(value: user) {
                HStack {
                    Text(user.name)
                    
                    Spacer()
                    
                    Text("\(user.jobs.count)")
                        .fontWeight(.black)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 8)
                        .background(.blue.gradient)
                        .foregroundStyle(.white)
                        .clipShape(.capsule(style: .continuous))
                    
                }
            }
        }
    }
    
    init(minimumJoinDate: Date, sortOrder: [SortDescriptor<User>]) {
        _users = Query(filter: #Predicate<User> { user in
            user.joinDate >= minimumJoinDate
        }, sort: sortOrder)
    }
}

#Preview {
    UsersView(minimumJoinDate: .now, sortOrder: [SortDescriptor(\User.name)])
        .modelContainer(for: User.self)
}
