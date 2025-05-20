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
        
        // Set the initial orientation
        updatePreviewLayerOrientation(previewLayer)
     
        view.layer.addSublayer(previewLayer)
        
        // Add a blur effect on top
        setupView(view: view, eyeModel: eyeModel)
        
        // Save the previewLayer as a tag so we can access it in updateUIView
        if let previewLayer = view.layer.sublayers?.first as? AVCaptureVideoPreviewLayer {
            view.tag = 1001  // Use this tag to identify the view with previewLayer
        }
        
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
    
    func updateUIView(_ uiView: UIView, context: Context) {
        // Update the preview layer orientation when the view is updated
        if uiView.tag == 1001, let previewLayer = uiView.layer.sublayers?.first as? AVCaptureVideoPreviewLayer {
            updatePreviewLayerOrientation(previewLayer)
            previewLayer.frame = UIScreen.main.bounds
        }
        
        // Refresh the blur effect
        setupView(view: uiView, eyeModel: eyeModel)
    }
    
    private func updatePreviewLayerOrientation(_ previewLayer: AVCaptureVideoPreviewLayer) {
        guard let connection = previewLayer.connection else { return }
        
        let currentDevice = UIDevice.current
        let orientation = currentDevice.orientation
        
        guard let interfaceOrientation = windowInterfaceOrientation() else { return }
        
        let videoOrientation: AVCaptureVideoOrientation
        
        switch interfaceOrientation {
        case .landscapeLeft:
            videoOrientation = .landscapeLeft  // Interface and video orientations are mirrored
        case .landscapeRight:
            videoOrientation = .landscapeRight
        case .portraitUpsideDown:
            videoOrientation = .portraitUpsideDown
        default:
            videoOrientation = .portrait
        }
        
        connection.videoOrientation = videoOrientation
    }
    
    // Helper method to get the current interface orientation
    private func windowInterfaceOrientation() -> UIInterfaceOrientation? {
        if #available(iOS 13.0, *) {
            return UIApplication.shared.windows.first?.windowScene?.interfaceOrientation
        } else {
            return UIApplication.shared.statusBarOrientation
        }
    }
}
