//
//  ScanActiveIngredients.swift
//  SafeDose
//
//  Created by Ashley Valdez on 4/27/24.
//

import SwiftUI

struct ActiveIngredientsScanInfo: View {
    @Binding var medicationName: String
    @State var activeIngredients = ""
    @State var dosage = ""
    @State var directions = ""
    @State var confirmInfo = false
    //@State var showScanner = false
    @State var Scan1 = false
    @State var texts: [ScanData] = [] //this will take the array of text and
    @EnvironmentObject var viewModel: AuthViewModel
    
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
            
            TextField("Dosage (e.g. 5 mg)", text: $dosage)
                .padding(.all)
                .background()
                .cornerRadius(10.0)
            Spacer()
                .frame(height: 20)
            
            TextField("Directions (e.g. Take two pills a day)", text: $directions)
                .padding(.all)
                .background()
                .cornerRadius(10.0)
            Spacer()
                .frame(height: 20)
            
            Button {
                Scan1 = true
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
            
            
            
            HomeScreen(activeIngredients: $activeIngredients, medicineName: $medicationName, dosage: $dosage, directions: $directions)
        }
        .sheet(isPresented: $Scan1, content : {
            makeScannerView()
        })
        .background(
            LinearGradient(gradient: Gradient(colors: [.pink, .red]), startPoint: .leading, endPoint: .trailing)
                .opacity(0.5)
        )
    }
    
    func makeScannerView() -> Scan {
       Scan(completion: {
           textPerPage in
           if let outputText = textPerPage?.joined(separator: "\n").trimmingCharacters(in:
                   .whitespacesAndNewlines) {
               let newScanData = ScanData(content: outputText)
               self.texts.append(newScanData)
           }
           self.Scan1 = false
       })
    }
    
}

#Preview {
    ActiveIngredientsScanInfo(medicationName: .constant("hehe"))
}


//
//@State var texts: [ScanData] = [] //this will take the array of text and
//@EnvironmentObject var viewModel: AuthViewModel
//@State var Scan1 = false
//
//
//
//
//.sheet(isPresented: $Scan1, content : {
//    makeScannerView()
//})
//
//func makeScannerView() -> Scan {
//   Scan(completion: {
//       textPerPage in
//       if let outputText = textPerPage?.joined(separator: "\n").trimmingCharacters(in:
//               .whitespacesAndNewlines) {
//           let newScanData = ScanData(content: outputText)
//           self.texts.append(newScanData)
//       }
//       self.Scan1 = false
//   })
//}
