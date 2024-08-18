//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Akshat Gandhi on 04/08/24.
//

import SwiftUI

struct ContentView: View {
    
    static private let arrCountriesName = ["Estonia", "France", "Germany", "India", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"]
    @State private var countries = arrCountriesName.shuffled()
    @State private var randomNumber = Int.random(in: 0...2)
    @State private var scoreTitle = ""
    @State private var showingScore = false
    @State private var totalScore = 0
    @State private var currentQuestionNumber = 0
    @State private var showingResults = false
    @State private var selectedFlag = -1
    
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
                            Text(countries[randomNumber])
                                .font(.largeTitle.weight(.semibold))
                        }
                        
                        ForEach(0..<3) { number in
                            Button {
                                flagTapped(number)
                            } label: {
                                Image(countries[number])
                                    .clipShape(.capsule)
                                    .shadow(radius: 5)
                            }
                            .rotation3DEffect(.degrees(selectedFlag == number ? 360 : 0), axis: (x: 0.0, y: 1.0, z: 0.0)
                            )
                            //.opacity(selectedFlag == -1 || selectedFlag == number ? 1.0 : 0.25)
                            //.scaleEffect(selectedFlag == -1 || selectedFlag == number ? 1.0 : 0.25)
                            .saturation(selectedFlag == -1 || selectedFlag == number ? 1 : 0)
                            .animation(.default, value: selectedFlag)
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
        selectedFlag = number
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
            let theirAnswer = countries[number]
            
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
        selectedFlag = -1
        countries.remove(at: randomNumber)
        countries.shuffle()
        randomNumber = Int.random(in: 0...2)
        currentQuestionNumber += 1
    }
    
    func newGame() {
        currentQuestionNumber = 0
        totalScore = 0
        countries = Self.arrCountriesName
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
