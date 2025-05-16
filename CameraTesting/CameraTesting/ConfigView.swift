//  ConfigView.swift
//  CameraTesting
//  Created by mrvl on 15/05/25.

import SwiftUI

struct ConfigView: View {
    @StateObject var configState: EyeModel
    @State private var showCameraView = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                //Background color
                Color.blue200.ignoresSafeArea()
                
                VStack(spacing: 18) {
                    // Header
                    VStack(spacing: 8) {
                        Text("iEye")
                            .font(.largeTitle)
                        Text("Now you see it now you dont")
                            .font(.headline)
                    }
                    
                    // Eye diseases
                    VStack(spacing: 16) {
                        Text("Eye Diseases")
                            .font(.headline)
                        
                        LazyVGrid(
                            columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: 2),
                            spacing: 16
                        ) {
                            ForEach(EyeDisease.allCases, id: \.self) { disease in
                                EyeButton(model: configState,
                                          disease: disease)
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .background(RoundedRectangle(cornerRadius: 12).fill(Color.white))
                    
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 12).fill(Color.white))
                    
                    // Stage of Severity
                    VStack(spacing: 16) {
                        Text("Eye Diseases")
                            .font(.headline)
                        Picker("", selection: $configState.severity) {
                            ForEach(Severity.allCases, id: \.self) { severity in
                                Text(severity.rawValue)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding(4)
                        .background(RoundedRectangle(cornerRadius: 12).fill(Color.blue200))
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 12).fill(Color.white))
                    
                    // Start button
                    Button(action:navigateToLoading) {
                        Text("Start the Simulation")
                            .frame(maxWidth: .infinity)
                            .frame(minHeight: 44)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.blue300))
                            .foregroundColor(Color.blue0)
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Spacer()
                }
                .padding(.horizontal)
            }
            .navigationDestination(isPresented: $showCameraView) {
                CameraView(eyemodel: configState)
            }
        }
    }
    
    
    func navigateToLoading() {
        showCameraView = true
    }
}

#Preview {
    ConfigView(configState: EyeModel(
    ))
}
