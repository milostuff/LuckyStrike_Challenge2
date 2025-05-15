//  ConfigView.swift
//  CameraTesting
//  Created by mrvl on 15/05/25.

import SwiftUI

struct ConfigView: View {
    @State private var selectedSeverity = 0
    var body: some View {
        ZStack {
            //Background color
            Color.blue200.ignoresSafeArea()
            
            VStack(spacing: 24) {
                // Header
                VStack(spacing: 8) {
                    Text("iEye")
                        .font(.largeTitle)
                    Text("Now you see it now you dont")
                        .font(.headline)
                }

                // Eye diseases
                VStack(spacing: 16) {
                    Text("Eye diseases")
                        .font(.headline)
                    HStack(spacing: 16) {
                        Spacer()
                        VStack {
                            ZStack {
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.blue200)
                                Image("Eye_Glaucoma")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .padding(.horizontal, 4)
                            }
                            .frame(width: 100, height: 100)
                            Text("Glaucoma")
                        }
                        Spacer()
                        VStack {
                            ZStack {
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.blue200)
                                Image("Eye_Cataract")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .padding(.horizontal, 4)
                            }
                            .frame(width: 100, height: 100)
                            Text("Cataract")
                        }
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 12).fill(Color.white))

                // Stage of Severity
                VStack(spacing: 16) {
                    Text("Stage of Severity")
                        .font(.headline)
                    Picker("", selection: $selectedSeverity) {
                        Text("Early").tag(0)
                        Text("Middle").tag(1)
                        Text("Late").tag(2)
                    }
                    .padding(4)
                    .pickerStyle(SegmentedPickerStyle())
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.blue200)
                    )
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 12).fill(Color.white))

                // Start button
                Button(action:{  }) {
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
    }
}

#Preview {
    ConfigView()
}
