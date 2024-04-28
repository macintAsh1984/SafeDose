//
//  EnterMedicationName.swift
//  SafeDose
//
//  Created by Ashley Valdez on 4/27/24.
//

import SwiftUI

struct EnterMedicationName: View {
    @State var medicationName = String()
    @State var navigateToScanInfo = false
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Enter Medication Name")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                TextField("Medication Name", text: $medicationName)
                    .padding(.all)
                    .background()
                    .cornerRadius(10.0)
                Button {
                    Task {
                        do {
                            try await viewModel.saveData(name: medicationName)
                            navigateToScanInfo = true
                        }catch {
                            print("Error sigining in")
                        }
                        
                    }
                    
                    
                } label: {
                    Text("Enter")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .tint(.pink)
                .controlSize(.large)
            } //end of Vstack
            .padding()
            .preferredColorScheme(.light)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                LinearGradient(gradient: Gradient(colors: [.pink, .red]), startPoint: .leading, endPoint: .trailing)
                    .opacity(0.5)
            )
            .navigationDestination(isPresented: $navigateToScanInfo) {
                ActiveIngredientsScanInfo(medicationName: $medicationName)
            }
        }
     }
}

//#Preview {
//    EnterMedicationName()
//}
