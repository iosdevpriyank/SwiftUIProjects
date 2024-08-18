//
//  AddView.swift
//  iExpense
//
//  Created by Akshat Gandhi on 18/08/24.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    
    var expenses: Expense
    let types = ["Personal", "Businesses"]
    let localCurrency = Locale.current.currency?.identifier ?? "INR"
    var body: some View {
        NavigationStack {
            Form {
                TextField("Item Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                
                TextField("Enter amount", value: $amount, format: .currency(code: localCurrency))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add New Expense")
            .toolbar(content: {
                Button("Save") {
                    let item = ExpenseItem(name: name, type: type, amount: amount)
                    expenses.items.append(item)
                    dismiss()
                }
            })
        }
    }
}

#Preview {
    AddView(expenses: Expense())
}
