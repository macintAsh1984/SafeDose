//
//  HomeScreen.swift
//  SafeDose
//
//  Created by Ashley Valdez on 4/27/24.
//

import SwiftUI

struct HomeScreen: View {
    @Binding var medicineName: String
    @Binding var dosage: String
    @Binding var directions: String
    @State var showInfo = false
    @State var addMedication = false
    @State var recordDosage = false
    var body: some View {
        //has the medicine name which opens to the question
        VStack {
            HStack {
                Spacer()
                Menu {
                    Button {
                        recordDosage = true
                    } label: {
                        Label("Record Dosage", systemImage: "pill.circle")
                            .font(.title)
                            .padding(5)
                    }
                    Button {
                        addMedication = true
                    } label: {
                        Label("Add Medication", systemImage: "plus")
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
            
            Form {
                Section {
                    NavigationLink(destination: DosageSummary()) {
                        Text(medicineName)
                    }
                }
            }
            .scrollContentBackground(.hidden)
        }
        .padding()
        .ignoresSafeArea(.keyboard)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .sheet(isPresented: $addMedication) {
            EnterMedicationName()
        }
        .sheet(isPresented: $recordDosage) {
            EnterDailyDosage()
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [.pink, .red]), startPoint: .leading, endPoint: .trailing)
                .opacity(0.5)
        )
    }
}

#Preview {
    HomeScreen(medicineName: .constant("medicine"), dosage: .constant("dosage"), directions: .constant("direction"))
}
