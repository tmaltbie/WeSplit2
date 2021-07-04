//
//  ContentView.swift
//  WeSplit2
//
//  Created by Trevor Maltbie on 6/24/21.
//

// CHALLENGE:
    // Use a conditional modifier to change the total amount text view to red if the user selects a 0% tip.

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 2
    @State private var textNumOfPeeps = "1"
    @State private var useRedTextForZeroTip = 4
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        let peopleCount = Double(textNumOfPeeps) ?? 0
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var grandTotal: Double {
        let grandTotal = totalPerPerson * (Double(textNumOfPeeps) ?? 0)
        return grandTotal
    }
    
    var numOfPeopleToString: String {
        let string = String(numberOfPeople)
        return string
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                }
                
                Section (header: Text("Number of people")){
                    TextField("Number of People", text: $textNumOfPeeps)
                    
                }
//                    Picker("Number of people", selection: $numberOfPeople) {
//                        ForEach(2 ..< 100) {
//                            Text("\($0) people")
//                        }
//                    }
                
                Section(header: Text("How much do you want to tip?")) {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("grand total:")) {
                    Text("$\(grandTotal, specifier: "%.2f")")
                }
                .foregroundColor(tipPercentage == 4 ? .red : .none)
                
                Section (header: Text("Amount per person")){
                    Text("$\(totalPerPerson, specifier: "%.2f")") // specifier to mean “a two-digit floating-point number.”
                }
            }
            .navigationTitle("We Split")
                
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
