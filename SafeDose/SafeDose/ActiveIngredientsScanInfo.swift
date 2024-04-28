//
//  ScanActiveIngredients.swift
//  SafeDose
//
//  Created by Ashley Valdez on 4/27/24.
//

import SwiftUI

struct ActiveIngredientsScanInfo: View {
    @Binding var medicationName: String
    @State var activeIngredients = "active ingredients"
    @State var dosage = "dosage"
    @State var directions = "directions"
    @State var confirmInfo = false
    @State var showScanner = false
    
    var body: some View {
        VStack (spacing: 0) {
            Text("Enter Active Ingredient Information")
                .font(.title)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
            Spacer()
                .frame(height: 20)
            
//            VStack (spacing: 5){
//                Color.clear
//                    .overlay{
//                        VStack (alignment: .leading) {
//                                Image("ActiveIngredients")
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fit)
//                                    .frame(width: 200, height: 200)
//
//
//                                Image("Directions")
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fit)
//                                    .frame(width: 200, height: 200)
//
//                        }
//                        .padding(.horizontal, 20)
//                }
//            }
            
            Text("Enter Manually")
                        .fontWeight(.semibold)
                    Spacer()
                        .frame(height: 20)
            
            TextField("Medication Name", text: $medicationName)
                .padding(.all)
                .background()
                .cornerRadius(10.0)
            Spacer()
                .frame(height: 20)
            
            TextField("Active Ingredients", text: $activeIngredients)
                .padding(.all)
                .background()
                .cornerRadius(10.0)
            Spacer()
                .frame(height: 20)
            
            TextField("Dosage", text: $dosage)
                .padding(.all)
                .background()
                .cornerRadius(10.0)
            Spacer()
                .frame(height: 20)
            
            TextField("Directions", text: $directions)
                .padding(.all)
                .background()
                .cornerRadius(10.0)
            Spacer()
                .frame(height: 20)
            
            Button {
                showScanner = true
            } label: {
                Label("Or Scan Medication", systemImage: "text.viewfinder")
                    .fontWeight(.medium)
                    .frame(maxWidth: .infinity)
            }
            Spacer()
                .frame(height: 20)
            
            Button {
                confirmInfo = true
            } label: {
                Text("Confirm Active Ingredients")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .tint(Color("PastelSalmon"))
            .controlSize(.large)
        }
        .padding()
        .ignoresSafeArea(.keyboard)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationDestination(isPresented: $confirmInfo) {
            HomeScreen(medicineName: $medicationName, dosage: $dosage, directions: $directions)
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [.pink, .red]), startPoint: .leading, endPoint: .trailing)
                .opacity(0.5)
        )
    }
}

#Preview {
    ActiveIngredientsScanInfo(medicationName: .constant("hehe"))
}
