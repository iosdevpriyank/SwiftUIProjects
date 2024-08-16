//
//  ContentView.swift
//  BetterRest
//
//  Created by Akshat Gandhi on 11/08/24.
//

import SwiftUI
import CoreML

struct ContentView: View {
    @State private var sleepAmount = 10.0
    @State private var wakeUp = defaultWakeUpTime
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    static var defaultWakeUpTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    
    var sleepTimeCalculate: String {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hoursIntoSeconds = (components.hour ?? 0) * 60 * 60
            let minuteIntoSeconds  = (components.minute ?? 0) * 60
            
            let predication = try model.prediction(wake: Double(hoursIntoSeconds + minuteIntoSeconds), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - predication.actualSleep
            return "Your bed time is " + sleepTime.formatted(date: .omitted, time: .shortened)
        } catch {
            return "There was a problem to calcuting a bed time."
        }
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("When do you want to wake up?") {
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }.font(.headline)
                
                Section("Desired amout of time") {
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                }.font(.headline)
                
                Section("Daily coffee intake") {
                    Picker("^[\(coffeeAmount) glass](inflect: true)", selection: $coffeeAmount) {
                        ForEach(1...21, id: \.self) {
                            Text(String($0))
                        }
                    }
                }.font(.headline)
                Text(sleepTimeCalculate)
                    .font(.title3)
            }
            .padding()
            .navigationTitle("BetterRest")
            
        }
    }
    
    func calculateBedTime() {
        
    }
}

#Preview {
    ContentView()
}
