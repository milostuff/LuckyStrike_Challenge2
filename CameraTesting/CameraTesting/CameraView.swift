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
            
            Image("Glaucoma")
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
        }
        .ignoresSafeArea()
        .onAppear {
            camera.configure()
        }
    }
}
