import SwiftUI

struct CameraView: View {
    var eyemodel: EyeModel
    @StateObject private var camera = CameraViewModel()
    @State private var isOverlayHidden = false
    
    var body: some View {
        ZStack {
            // Camera Preview
            CameraPreview(eyeModel: eyemodel, session: camera.session)
                .frame(maxWidth: .infinity, maxHeight: .infinity) 
                .ignoresSafeArea()
            
            // Overlay Image
//            Image(eyemodel.eyeDisease.rawValue + "_" + eyemodel.severity.rawValue)
//                .resizable()
//                .frame(maxWidth: .infinity, maxHeight: .infinity)
//                .ignoresSafeArea()
            
            // Description Overlay
            HStack {
                Image("Glaucoma_Desc")
                    .resizable()
                
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
            .frame(width: 320*2, height: 320)
            .background (Color.blue200.opacity(isOverlayHidden ? 0 : 1))
            .clipShape(RoundedRectangle(cornerRadius: 18))
            .opacity(isOverlayHidden ? 0 : 1)
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

#Preview {
    CameraView(eyemodel: EyeModel())
}
