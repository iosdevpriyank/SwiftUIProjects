//
//  ContentView.swift
//  WeSplit
//
//  Created by Akshat Gandhi on 03/08/24.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountFieldFocused: Bool
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalGrossAmount: Double {
        let tipSelection = Double(tipPercentage)
        var grossAmount = checkAmount
        if tipSelection != 0.0 {
            let tipAmount = checkAmount / 100 * tipSelection
            grossAmount = checkAmount + tipAmount
        }
        return grossAmount
    }
    
    var totalPerPerson: Double {
        let totalPeopleCount = Double(numberOfPeople + 2)
        let perPersonCharges = totalGrossAmount / totalPeopleCount
        
        return perPersonCharges
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "INR"))
                        .keyboardType(.decimalPad)
                        .focused($amountFieldFocused)
                    
                    Picker("Number of People", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) People")
                        }
                    }
                    .pickerStyle(.navigationLink)
                    
                }
                Section("How you want to pay tip?") {
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(0..<101) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section {
                    HStack{
                        Text("Gross Amount")
                        Spacer()
                        Text("\(totalGrossAmount)")
                            .multilineTextAlignment(.leading)

                    }
                }
                
                Section("Amount per person") {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "INR"))
                }
            }
            .navigationTitle("Tip Calculator")
            .toolbar {
                if amountFieldFocused {
                    Button("Done") {
                        amountFieldFocused.toggle()
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

//@State private var name: String = ""
//var body: some View {
//    Form {
//        TextField("Enter your name", text: $name)
//        Text("My name is \(name)")
//    }
//}


//var arrFamily = ["Priyank Gandhi", "Akshat Gandhi", "Manisha Gandhi"]
//@State private var selectedFamilyMember: String = "Manisha Gandhi"
//var body: some View {
//    NavigationStack {
//        Form {
//            Picker("Select your Family Head", selection: $selectedFamilyMember) {
//                ForEach(arrFamily,id: \.self) {
//                    Text($0)
//                }
//            }
//        }
//        .navigationTitle("Selected Family Head")
//    }
//}
