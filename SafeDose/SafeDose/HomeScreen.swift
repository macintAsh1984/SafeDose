//
//  HomeScreen.swift
//  SafeDose
//
//  Created by Ashley Valdez on 4/27/24.
//

import SwiftUI

struct HomeScreen: View {
    @Binding var activeIngredients: String
    @Binding var medicineName: String
    @Binding var dosage: String
    @Binding var directions: String
    @State var showInfo = false
    @State var addMedication = false
    @State var recordDosage = false
    @EnvironmentObject var viewModel: AuthViewModel
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
                    NavigationLink(destination: DosageSummary(Dosage: $dosage, medicineName: $medicineName)) {
                        Text(medicineName)
                    }
                }
            }
            .scrollContentBackground(.hidden)
//            Button {
//                showInfo = true
//            } label: {
//                ZStack(alignment: .leading) {
//                    RoundedRectangle(cornerRadius: 20)
//                        .frame(height: 110)
//                        .foregroundColor(.clear)
//                        .background(
//                            LinearGradient(gradient: Gradient(colors: [.black, .green]), startPoint: .leading, endPoint: .trailing)
//                        )
//                        .cornerRadius(20)
//                    VStack (alignment: .leading){
//                        Text("\(medicineName)")
//                            .fontWeight(.semibold)
//                            .foregroundColor(.white)
//                            .frame(maxWidth: .infinity)
//                            .multilineTextAlignment(.leading)
//                    }
//                    Spacer()
//                        .frame(height: 20)
//                    HStack {
//                        Text("\(dosage)")
//                            .fontWeight(.semibold)
//                            .foregroundColor(.white)
//                            .frame(maxWidth: .infinity)
//                        Text("\(directions)")
//                            .fontWeight(.semibold)
//                            .foregroundColor(.white)
//                            .frame(maxWidth: .infinity)
//                    }
//                }
//            }
//            .buttonStyle(.borderedProminent)
//            .tint(Color("PastelSalmon"))
//            .controlSize(.large)
        }
        .padding()
        .ignoresSafeArea(.keyboard)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .sheet(isPresented: $addMedication) {
            EnterMedicationName()
        }
        .sheet(isPresented: $recordDosage) {
            EnterDailyDosage( medicineName: $medicineName)//medicine name)
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [.pink, .red]), startPoint: .leading, endPoint: .trailing)
                .opacity(0.5)
        )
        
        .onAppear {
            Task {
                await viewModel.savedosage(dosage: dosage)
                await viewModel.savedirections(directions: directions)
                await viewModel.saveActiveIngredients(ingredients: activeIngredients)
            }
            
        }
    }
}


