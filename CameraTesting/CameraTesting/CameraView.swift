//
//  CameraView.swift
//  CameraTesting
//
//  Created by Franky on 10/05/25.
//

import SwiftUI

struct CameraView: View {
    var eyemodel: EyeModel 
    @StateObject private var camera = CameraViewModel()
    @State private var isOverlayHidden = false 
    
    var body: some View {
        ZStack {
            CameraPreview(eyeModel: eyemodel,session: camera.session)
                .ignoresSafeArea()
            
            Image(eyemodel.eyeDisease.rawValue + "_" + eyemodel.severity.rawValue)
                .resizable()
                .aspectRatio( contentMode: .fill)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                if let image = camera.capturedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                }
                //                Button(action: {
                //                    camera.takePhoto()
                //                }) {
                //                    Circle()
                //                        .fill(Color.white)
                //                        .frame(width: 70, height: 70)
                //                        .shadow(radius: 5)
                //                }
                //                .padding()
            }
        } .contentShape(Rectangle()) // Makes the whole area tappable
            .onTapGesture {
                isOverlayHidden.toggle()
            }
        .navigationBarBackButtonHidden(isOverlayHidden)
        .navigationTitle(eyemodel.eyeDisease.rawValue)
        .navigationBarTitleDisplayMode(.inline) // Keeps it compact
        .ignoresSafeArea()
        .onAppear {
            camera.configure()
        }
    }
}
