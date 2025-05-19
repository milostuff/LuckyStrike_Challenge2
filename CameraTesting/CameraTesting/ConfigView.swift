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
                
                ZStack {
                    HStack(spacing: 18) {
                        // Header
                        //                    VStack(spacing: 8) {
                        //                        Text("iEye")
                        //                            .font(.largeTitle)
                        //                        Text("Now you see it now you dont")
                        //                            .font(.headline)
                        //                    }
                        
                        // Eye diseases
                        VStack(spacing: 16) {
                            Text("Glaucoma")
                                .font(.title2)
                                .fontWeight(.bold)
                            VStack(alignment: .leading)
                            {
                                EyeButton(model: configState, disease: EyeDisease.Glaucoma) 
                            }
                            .frame(maxWidth: .infinity)
                        }
                        .padding()
                        
                        
                        VStack()
                        {
                            // Stage of Severity
                            VStack(spacing: 16) {
                                Text("Eye Diseases")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                Picker("", selection: $configState.severity) {
                                    ForEach(Severity.allCases, id: \.self) { severity in
                                        Text(severity.rawValue)
                                    }
                                }
                                .pickerStyle(SegmentedPickerStyle())
                                .padding(4)
                                .background(RoundedRectangle(cornerRadius: 12).fill(Color.blue200))
                                
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
                            }
                            .padding()
                        }
                    }
                    .background(RoundedRectangle(cornerRadius: 12).fill(Color.white))
                }
                .padding(.horizontal, 120)
            }
            .ignoresSafeArea()
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
