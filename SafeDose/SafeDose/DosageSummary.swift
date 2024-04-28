//
//  DosageSummary.swift
//  SafeDose
//
//  Created by Ashley Valdez on 4/27/24.
//

import SwiftUI
import Charts

struct DosageAmount : Identifiable {
    let id = UUID()
    
    let day: String
    var amount: Int
    let color: Color
}

var dosageData: [DosageAmount] = [
    .init(day: "Sun", amount: 10, color: .blue),
    .init(day: "Mon", amount: 0, color: .red),
    .init(day: "Tue", amount: 0, color: .green),
    .init(day: "Wed", amount: 0, color: .orange),
    .init(day: "Thu", amount: 0, color: .pink),
    .init(day: "Fri", amount: 0, color: .purple),
    .init(day: "Sat", amount: 0, color: .cyan)
]

struct DosageSummary: View {
    @State var birdAmt = String()
    @State var medicine = "Claritin"
    @State var percent = 30
    @State var addSymptoms = false
    var body: some View {
        NavigationStack {
            VStack {
                    HStack {
                        Spacer()
                        Menu {
                            Button {
                                addSymptoms = true
                            } label: {
                                Label("Add Symptoms", systemImage: "plus")
                                    .font(.title)
                                    .padding(5)
                            }
                        } label: {
                            Image(systemName: "plus")
                                .font(.title)
                                .foregroundColor(.pink)
                                .padding(5)
                        }
                    } // End of menu options
                    
                    Chart(dosageData) { element in
                        BarMark (
                            x: .value("Day", element.day),
                            y: .value("Dosage Per Day", element.amount)
                        )
                        .foregroundStyle(element.color)
                    }
                
                Text("Your dosage for \(medicine) was \(percent)% higher than recommended.")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                Spacer()
                    .frame(height: 20)
                    
                }
            .padding()
            .preferredColorScheme(.light)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                LinearGradient(gradient: Gradient(colors: [.pink, .red]), startPoint: .leading, endPoint: .trailing)
                    .opacity(0.5)
            )
            .sheet(isPresented: $addSymptoms) {
                ScanActiveIngredients()
            }
        }

    }
    
    /// Sample Code
    // 1. Get the date
    // 2. Get the # of birds seen at the date
    // 3. Iterate through the dates in the chart. If date equals one of the days in the chart, update the day's y-value.
    func recordBirdCount() {
        let date = Date().formatted(.dateTime.weekday(.abbreviated))
        for index in 0..<dosageData.count {
            if dosageData[index].day == date {
                dosageData[index].amount = Int(birdAmt) ?? 0
                birdAmt = String()
            }
        }
    }
}

#Preview {
    DosageSummary()
}
