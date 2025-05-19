//
//  EyeButton.swift
//  CameraTesting
//
//  Created by mrvl on 16/05/25.
//

import SwiftUI

struct EyeButton: View {
    @ObservedObject var model: EyeModel
    var disease: EyeDisease
    
    var body: some View {
        Button(action: {
            model.eyeDisease = disease
        }) {
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(model.eyeDisease == disease ? Color.blue300 : Color.blue200)
                        .animation(.easeInOut, value: model.eyeDisease == disease)
                    
                    Image("Eye_" + disease.rawValue)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.horizontal, 4)
                }
                .frame(width: 100, height: 100)
                
                Text(model.description)
                    .multilineTextAlignment(.center) 
            }
            .animation(.easeInOut, value: model.eyeDisease == disease)
        }
        .buttonStyle(PlainButtonStyle())
    }
}
