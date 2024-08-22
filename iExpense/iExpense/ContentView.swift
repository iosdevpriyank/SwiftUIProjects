//
//  ContentView.swift
//  iExpense
//
//  Created by Akshat Gandhi on 18/08/24.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable, Equatable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

@Observable
class Expense {
    var personalItems: [ExpenseItem] {
        items.filter({ $0.type == "Personal" })
    }
    
    var businessItems: [ExpenseItem] {
        items.filter({ $0.type == "Businesses" })
    }
    var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.setValue(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodeItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodeItems
                return
            }
        }
        items = []
    }
}

struct ContentView: View {
    @State private var expense = Expense()
    @State private var isShowingExpense = false
    
    var body: some View {
        NavigationStack {
            List {
                ExpanseSection(title: "Business", expenses: expense.businessItems, deleteItems: removeBusinessItems)
                ExpanseSection(title: "Personal", expenses: expense.personalItems, deleteItems: removePersonalItems)
              }
            .navigationTitle("iExpense")
            .toolbar {
                NavigationLink {
                    AddView(expenses: expense)
                } label: {
                    Label("Add Expense", systemImage: "plus")
                }
            }
        }
    }
    
    func removeItems(at offsets: IndexSet,in inputArray: [ExpenseItem]) {
        var objecDelete = IndexSet()
        
        for offset in offsets {
            let item = inputArray[offset]
            
            if let index = expense.items.firstIndex(of: item) {
                objecDelete.insert(index)
            }
        }
        expense.items.remove(atOffsets: objecDelete)
    }
    
    func removePersonalItems(at offsets: IndexSet) {
        removeItems(at: offsets, in: expense.personalItems)
    }
    
    func removeBusinessItems(at offsets: IndexSet) {
        removeItems(at: offsets, in: expense.businessItems)
    }
}

extension View {
    func style(for item: ExpenseItem) -> some View {
        if item.amount < 10 {
            return self.font(.body)
        } else if item.amount < 100 {
            return self.font(.title3)
        } else {
            return self.font(.title)
        }
    }
}

struct ExpanseSection: View {
    let title: String
    let expenses: [ExpenseItem]
    let deleteItems: (IndexSet) -> Void
    let localCurrency = Locale.current.currency?.identifier ?? "INR"
    var body: some View {
        Section(title) {
            ForEach(expenses) { item in
                HStack {
                    VStack(alignment:.leading) {
                        Text(item.name)
                            .font(.headline)
                        
                        Text(item.type)
                            .font(.subheadline)
                    }
                    Spacer()
                    Text(item.amount, format: .currency(code: localCurrency))
                        .style(for: item)
                }
            }
            .onDelete(perform: deleteItems)
        }
    }
}

#Preview {
    ContentView()
}
