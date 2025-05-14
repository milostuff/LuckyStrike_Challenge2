//
//  CameraPreview.swift
//  CameraTesting
//
//  Created by Franky on 10/05/25.
//

import AVFoundation
import SwiftUI

struct CameraPreview: UIViewRepresentable {
    let session: AVCaptureSession
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.frame = UIScreen.main.bounds
        view.layer.addSublayer(previewLayer)
//        
//        // Add a blur effect on top
//        let blurEffect = UIBlurEffect(style: .systemThinMaterial)
//        let blurView = UIVisualEffectView(effect: blurEffect)
//        blurView.frame = UIScreen.main.bounds
//        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        view.addSubview(blurView)
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}
