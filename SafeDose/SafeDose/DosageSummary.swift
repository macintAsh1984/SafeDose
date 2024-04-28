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
    var body: some View {
            VStack {
                Chart(dosageData) { element in
                    BarMark (
                        x: .value("Day", element.day),
                        y: .value("Dosage Per Day", element.amount)
                    )
                    .foregroundStyle(element.color)
                }
                
            }
            .padding()

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
