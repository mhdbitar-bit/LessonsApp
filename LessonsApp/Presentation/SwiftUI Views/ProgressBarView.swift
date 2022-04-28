//
//  ProgressBarView.swift
//  LessonsApp
//
//  Created by Mohammad Bitar on 4/28/22.
//

import SwiftUI

struct ProgressBarView: View {
    @State private var progress: Double = 0
    private let total: Double = 1
    
    var body: some View {
        VStack {
            ZStack {
                ProgressView("Downloading...", value: progress, total: total)
                    .progressViewStyle(LinearProgressViewStyle())
                    .padding()
            }
        }
    }
}

struct ProgressBarView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBarView()
    }
}
