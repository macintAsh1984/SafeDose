//
//  ScanActiveIngredients.swift
//  SafeDose
//
//  Created by Ashley Valdez on 4/27/24.
//

import SwiftUI

struct ScanActiveIngredients: View {
    
    // MARK: - State Variables
    // State variables for the questionnaire.
    @State var selectedOption: Int? = nil
    @State var isLoading = false
    @State var showAlert = false
    
    // MARK: - Options
    // Options for the questionnaire
    var options = [
        "Shallow Breathing",
        "Confusion",
        "Lessened Alertness",
        "Loss of Conciousness",
        "Small Pupils",
        "Blue skin from poor circulation"
    ]
    
    @State var symptoms = false
    @State var shallowBreathing = false
    @State var confusion = false
    @State var lessenedAlertness = false
    @State var lossOfConciousness = false
    @State var smallPupils = false
    @State var blueSkin = false
    @State var count = 0
    var body: some View {
        NavigationStack {
            VStack {
                Text("Symptoms")
                    .font(.title)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                Spacer()
                    .frame(height: 20)
                
                Button(action: {shallowBreathing.toggle()}){
                    HStack {
                        Text("Shallow Breathing")
                            .fontWeight(.medium)
                        Spacer()
                        if self.shallowBreathing {
                            Image(systemName: "checkmark")
                        }
                    }
                    .padding()
                    .background(self.shallowBreathing ? .red : Color("PastelSalmon"))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                    .padding(.horizontal)
                
                Button(action: {confusion.toggle()}){
                    HStack {
                        Text("Confusion")
                            .fontWeight(.medium)
                        Spacer()
                        if self.confusion {
                            Image(systemName: "checkmark")
                        }
                    }
                    .padding()
                    .background(self.confusion ? .red : Color("PastelSalmon"))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                    .padding(.horizontal)
                
                Button(action: {lessenedAlertness.toggle()}){
                    HStack {
                        Text("Lessened Alertness")
                            .fontWeight(.medium)
                        Spacer()
                        if self.lessenedAlertness {
                            Image(systemName: "checkmark")
                        }
                    }
                    .padding()
                    .background(self.lessenedAlertness ? .red : Color("PastelSalmon"))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                    .padding(.horizontal)
                
                Button(action: {lossOfConciousness.toggle()}){
                    HStack {
                        Text("Loss of Conciousness")
                            .fontWeight(.medium)
                        Spacer()
                        if self.lossOfConciousness {
                            Image(systemName: "checkmark")
                        }
                    }
                    .padding()
                    .background(self.lossOfConciousness ? .red : Color("PastelSalmon"))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                    .padding(.horizontal)
                
                Button(action: {smallPupils.toggle()}){
                    HStack {
                        Text("Small Pupils")
                            .fontWeight(.medium)
                        Spacer()
                        if self.smallPupils {
                            Image(systemName: "checkmark")
                        }
                    }
                    .padding()
                    .background(self.smallPupils ? .red : Color("PastelSalmon"))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                    .padding(.horizontal)
                
                Button(action: {blueSkin.toggle()}){
                    HStack {
                        Text("Blue skin from poor circulation")
                            .fontWeight(.medium)
                        Spacer()
                        if self.blueSkin {
                            Image(systemName: "checkmark")
                        }
                    }
                    .padding()
                    .background(self.blueSkin ? .red : Color("PastelSalmon"))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                    .padding(.horizontal)

                Spacer().frame(height: 20)
                
                Button {
                    if(shallowBreathing){
                        count = count + 1
                    }
                    if(confusion){
                        count = count + 1
                    }
                    if(lessenedAlertness){
                        count = count + 1
                    }
                    if(lossOfConciousness){
                        count = count + 1
                    }
                    if(smallPupils){
                        count = count + 1
                    }
                    if(blueSkin){
                        count = count + 1
                    }
                    if(count > 2){
                        symptoms = true
                    }
                } label: {
                    Text("Done")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .tint(.pink)
                .controlSize(.large)
            }
            .padding()
            .preferredColorScheme(.light)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                LinearGradient(gradient: Gradient(colors: [.pink, .red]), startPoint: .leading, endPoint: .trailing)
                    .opacity(0.5)
            )
            .navigationDestination(isPresented: $symptoms) {
                DosageSummary()
            }
        }
    }
}

#Preview {
    ScanActiveIngredients()
}
