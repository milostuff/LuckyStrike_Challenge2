//
//  CameraPreview.swift
//  CameraTesting
//
//  Created by Franky on 10/05/25.
//

import AVFoundation
import SwiftUI

struct CameraPreview: UIViewRepresentable {
    var eyeModel: EyeModel
    let session: AVCaptureSession
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        // Set up the camera preview layer
        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.frame = UIScreen.main.bounds
        view.layer.addSublayer(previewLayer)
        
        // Add a blur effect on top
        setupView(view: view, eyeModel: eyeModel)
        
        return view
    }
    
    func setupView(view: UIView, eyeModel: EyeModel) {
        // Remove existing blur views
        view.subviews.forEach { subview in
            if subview is UIVisualEffectView {
                subview.removeFromSuperview()
            }
        }
        
        // Add blur effect based on disease type
        let blurEffect: UIBlurEffect?
        
        switch eyeModel.eyeDisease {
        case .Glaucoma:
            blurEffect = nil  // No blur for Glaucoma
        case .Cataract:
            blurEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        case .DiabeticRetinopathy:
            blurEffect = UIBlurEffect(style: .systemThickMaterial)
        case .BlurredVision:
            blurEffect = UIBlurEffect(style: .systemThinMaterial)
        case .MacularDegeneration:
            blurEffect = UIBlurEffect(style: .systemMaterial)
        }
        
        // Add the blur view if effect is defined
        if let effect = blurEffect {
            let blurView = UIVisualEffectView(effect: effect)
            blurView.frame = UIScreen.main.bounds
            blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            view.addSubview(blurView)
        }
    }

    
    func updateUIView(_ uiView: UIView, context: Context) {}
}
