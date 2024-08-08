//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Akshat Gandhi on 04/08/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var arrCountriesName = ["Estonia", "France", "Germany", "India", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var randomNumber = Int.random(in: 0...2)
    @State private var scoreTitle = ""
    @State private var showingScore = false
    @State private var totalScore = 0
    @State private var currentQuestionNumber = 0
    @State private var showingResults = false
    var totalQuestion = 8
    
    var body: some View {
        ZStack {
            RadialGradient(stops:[
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3), .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)], center: .top, startRadius: 200, endRadius: 400)
            .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Guess The Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                VStack {
                    VStack(spacing: 15) {
                        VStack {
                            Text("Take the flag of")
                                .foregroundStyle(.secondary)
                                .font(.subheadline.weight(.heavy))
                            Text(arrCountriesName[randomNumber])
                                .font(.largeTitle.weight(.semibold))
                        }
                        
                        ForEach(0..<3) { number in
                            Button {
                                flagTapped(number)
                            } label: {
                                Image(arrCountriesName[number])
                                    .clipShape(.capsule)
                                    .shadow(radius: 5)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(.regularMaterial)
                    .clipShape(.rect(cornerRadius: 20))
                    Spacer()
                    Spacer()
                    Text("Score: \(totalScore)")
                        .foregroundStyle(.white)
                        .font(.title.bold())
                    Spacer()
                }.padding()
            }
            .alert(scoreTitle, isPresented: $showingScore) {
                Button("Continue", action: askQuestion)
            } message: {
                Text("Your score is \(totalScore)")
            }.alert("Game Over", isPresented: $showingResults) {
                Button("Start Again", action: newGame)
            } message: {
                Text("Your final score was \(totalScore)")
            }
        }
    }
    
    func flagTapped(_ number: Int) {
        if currentQuestionNumber == totalQuestion {
            showingResults = true
        } else {
            showingScore = true
        }
        if number == randomNumber {
            scoreTitle = "Right"
            totalScore += 1
        } else {
            let needsThe = ["UK", "US", "India"]
            let theirAnswer = arrCountriesName[number]
            
            if needsThe.contains(theirAnswer) {
                scoreTitle = "Wrong! That’s the flag of the \(theirAnswer)"
            } else {
                scoreTitle = "Wrong! That’s the flag of \(theirAnswer)"
            }
            
            if totalScore > 0 {
                totalScore -= 1
            }
        }
    }
    
    func askQuestion() {
        arrCountriesName.shuffle()
        randomNumber = Int.random(in: 0...2)
        currentQuestionNumber += 1
    }
    
    func newGame() {
        currentQuestionNumber = 0
        totalScore = 0
        askQuestion()
    }
}

#Preview {
    ContentView()
}

//ZStack {
//    VStack(spacing:0) {
//        Color.red
//        Color.blue
//    }
//
//    Text("Manisha Gandhi")
//        .padding(50)
//        .background(.ultraThinMaterial)
//        .foregroundStyle(.secondary)
//}
//.ignoresSafeArea()
