//
//  EnterDailyDosage.swift
//  SafeDose
//
//  Created by Ashley Valdez on 4/27/24.
//

import SwiftUI

struct EnterDailyDosage: View {
    @State var dosage = String()
    @State var dosageEntered = false
    var body: some View {
        //how much did they take today?
        NavigationStack {
            VStack {
                Text("How much dosage did you take today?")
                    .font(.title)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                Spacer()
                    .frame(height: 20)
                
                TextField("Dosage (e.g. 5 mg)", text: $dosage)
                    .padding(.all)
                    .background()
                    .cornerRadius(10.0)
                Spacer()
                    .frame(height: 20)
                
                Button {
                    dosageEntered = true
                } label: {
                    Text("Enter Dosage")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .tint(Color("PastelSalmon"))
                .controlSize(.large)
            } //end of Vstack
            .padding()
            .ignoresSafeArea(.keyboard)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                LinearGradient(gradient: Gradient(colors: [.pink, .red]), startPoint: .leading, endPoint: .trailing)
                    .opacity(0.5)
            )
            .navigationDestination(isPresented: $dosageEntered) {
                DosageSummary()
            }
        }
    }
    
}

#Preview {
    EnterDailyDosage()
}
