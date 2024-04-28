//
//  ScanData.swift
//  SafeDose
//
//  Created by Sukhpreet Aulakh on 4/28/24.
//

import Foundation

struct ScanData: Identifiable {
    //@EnvironmentObject var viewModel: AuthViewModel
    var id = UUID()
    let content:String
    
    init(content: String) {
        self.content = content
    }
}

