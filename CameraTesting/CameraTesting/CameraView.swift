import SwiftUI

struct CameraView: View {
    var eyemodel: EyeModel
    @StateObject private var camera = CameraViewModel()
    @State private var isOverlayHidden = false
    
    var body: some View {
        ZStack {
            // Camera Preview
            CameraPreview(eyeModel: eyemodel, session: camera.session)
                .ignoresSafeArea()
            
            // Overlay Image
            Image(eyemodel.eyeDisease.rawValue + "_" + eyemodel.severity.rawValue)
                .resizable()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
            
            // Description Overlay
            VStack {
                Text(eyemodel.description)
                    .padding()
                    .frame(width: 300, height: 300)
                    .background(Color.blue.opacity(0.8))
                    .cornerRadius(18)
                    .opacity(isOverlayHidden ? 0 : 1)
            }
            .ignoresSafeArea()  // Make sure the whole screen is tappable
        }
        .navigationBarBackButtonHidden(isOverlayHidden)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(eyemodel.eyeDisease.rawValue)
                    .font(.headline)
                    .foregroundStyle(.white)
                    .opacity(isOverlayHidden ? 0 : 1)
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                } label: {
                    Image(systemName: "info.circle.fill")
                        .foregroundColor(.white)
                }
                .opacity(isOverlayHidden ? 0 : 1)
            }
        }
        .onAppear {
            camera.configure()
        }
        .onTapGesture {
            isOverlayHidden.toggle()
        }
    }
} 
