import SwiftUI

struct CameraView: View {
    var eyemodel: EyeModel
    @StateObject private var camera = CameraViewModel()
    @State private var isOverlayHidden = false
    @State private var orientation = UIDevice.current.orientation
    
    var body: some View {
        ZStack {
            // Camera Preview - passes the current orientation to trigger updates
            CameraPreview(eyeModel: eyemodel, session: camera.session)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
                .id(camera.orientation) // Force refresh when orientation changes
            
            // Overlay Image
            Image(eyemodel.eyeDisease.rawValue + "_" + eyemodel.severity.rawValue)
                .resizable()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
            
            // Description Overlay - adapt the layout based on orientation
            Group {
                // This is the weird part
                if !UIDevice.current.orientation.isLandscape {
                    // Landscape layout
                    HStack {
                        Image("Glaucoma_Desc")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: UIScreen.main.bounds.height * 0.6)
                        
                        Spacer()
                        
                        VStack {
                            Text("Description")
                                .font(.title3)
                                .fontWeight(.semibold)
                            Text(eyemodel.longDescription)
                                .padding()
                                .cornerRadius(18)
                        }
                        .foregroundStyle(.white)
                    }
                    .frame(width: UIScreen.main.bounds.width * 0.8)
                    .frame(height: UIScreen.main.bounds.height * 0.6)
                }
            }
            .background(Color.blue200.opacity(isOverlayHidden ? 0 : 1))
            .clipShape(RoundedRectangle(cornerRadius: 18))
            .opacity(isOverlayHidden ? 0 : 1)
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
                    // Info button action
                } label: {
                    Image(systemName: "info.circle.fill")
                        .foregroundColor(.white)
                }
                .opacity(isOverlayHidden ? 0 : 1)
            }
        }
        .onAppear {
            // Set up orientation detection
            UIDevice.current.beginGeneratingDeviceOrientationNotifications()
            
            // Initialize camera
            camera.configure()
        }
        .onDisappear {
            UIDevice.current.endGeneratingDeviceOrientationNotifications()
        }
        .onTapGesture {
            isOverlayHidden.toggle()
        }
        .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
            // Update our local orientation state when device orientation changes
            orientation = UIDevice.current.orientation
        }
    }
}

#Preview {
    CameraView(eyemodel: EyeModel())
}
