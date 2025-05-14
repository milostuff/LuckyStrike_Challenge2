//
//  CameraView.swift
//  CameraTesting
//
//  Created by Franky on 10/05/25.
//

import SwiftUI

struct CameraView: View {
    @StateObject private var camera = CameraViewModel()

    var body: some View {
        ZStack {
            CameraPreview(session: camera.session)
                .ignoresSafeArea()
            
            Circle()
                .fill(Color.black.opacity(0.6))
                .frame(width: 100, height: 100)
                .position(x: 200, y: 300)
            
            VStack {
                Spacer()
                if let image = camera.capturedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                }
                Button(action: {
                    camera.takePhoto()
                }) {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 70, height: 70)
                        .shadow(radius: 5)
                }
                .padding()
            }
        }
        .onAppear {
            camera.configure()
        }
    }
}
