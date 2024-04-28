//
//  ScanActiveIngredients.swift
//  SafeDose
//
//  Created by Ashley Valdez on 4/27/24.
//

import SwiftUI

struct ActiveIngredientsScanInfo: View {
    @State var Scan = false
    var body: some View {
        VStack{
            Text("Enter Active Ingredient Information")
            Image("ActiveIngredients")
                .resizable()
                .scaledToFit()
                .frame(width: 250, height: 250)
            Button ("Scan") {
                //Scan
                Scan = true;
            }
            .padding(.horizontal, 150)
            .padding(.vertical, 20)
            .background(Color("PastelSalmon"))
            .foregroundColor(Color("PastelWhite"))
            .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
            .frame(width: 400, height: 100)
        }
        .ignoresSafeArea(.keyboard)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationDestination(isPresented: $Scan) {
            //Integrate the scanner
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [.pink, .red]), startPoint: .leading, endPoint: .trailing)
                .opacity(0.5)
        )
    }
}

#Preview {
    ActiveIngredientsScanInfo()
}
