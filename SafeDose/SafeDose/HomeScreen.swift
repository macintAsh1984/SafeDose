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
    var body: some View {
        //has the medicine name which opens to the question
        VStack{
            Form {
                Section {
                    NavigationLink(destination: DosageSummary()) {
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
        .navigationDestination(isPresented: $showInfo) {
            //
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
