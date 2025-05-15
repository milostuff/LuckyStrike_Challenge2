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

        // Set up the camera preview layer
        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.frame = UIScreen.main.bounds
        view.layer.addSublayer(previewLayer)

        // Create a live blur effect using CIFilter
        let blurView = UIImageView(frame: UIScreen.main.bounds)
        blurView.contentMode = .scaleAspectFill
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        // Capture the current screen and apply the blur
        DispatchQueue.global(qos: .userInitiated).async {
            let screenSize = UIScreen.main.bounds.size
            let renderer = UIGraphicsImageRenderer(size: screenSize)
            let snapshot = renderer.image { _ in
                view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
            }

            // Apply the light blur filter
            if let ciImage = CIImage(image: snapshot) {
                let filter = CIFilter(name: "CIGaussianBlur")
                filter?.setValue(ciImage, forKey: kCIInputImageKey)
                filter?.setValue(5.0, forKey: kCIInputRadiusKey)  // Lightest blur

                if let outputImage = filter?.outputImage,
                   let cgImage = CIContext().createCGImage(outputImage, from: ciImage.extent) {
                    DispatchQueue.main.async {
                        blurView.image = UIImage(cgImage: cgImage)
                    }
                }
            }
        }

        view.addSubview(blurView)
        return view
    }

    
    func updateUIView(_ uiView: UIView, context: Context) {}
}
