//  CameraViewModel.swift
//  CameraTesting
//  Created by Franky on 10/05/25.

import AVFoundation
import SwiftUI

class CameraViewModel: NSObject, ObservableObject, AVCapturePhotoCaptureDelegate {
    @Published var capturedImage: UIImage?
    @Published var orientation = UIDevice.current.orientation
    let session = AVCaptureSession()
    private let output = AVCapturePhotoOutput()
    private let queue = DispatchQueue(label: "camera.queue")
    
    override init() {
        super.init()
        configure()
        setupOrientationListener()
    }
    
    func configure() {
        session.beginConfiguration()
        defer { session.commitConfiguration() }
        
        guard let device = AVCaptureDevice.default(for: .video),
              let input = try? AVCaptureDeviceInput(device: device),
              session.canAddInput(input),
              session.canAddOutput(output) else {
            return
        }
        
        session.addInput(input)
        session.addOutput(output)
        
        // We'll handle orientation in the preview layer directly
        
        queue.async { self.session.startRunning() }
    }
    
    func setupOrientationListener() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(orientationChanged),
                                               name: UIDevice.orientationDidChangeNotification,
                                               object: nil)
    }
    
    @objc func orientationChanged() {
        // Update published orientation to trigger UI updates
        DispatchQueue.main.async {
            self.orientation = UIDevice.current.orientation
        }
    }
    
    func takePhoto() {
        let settings = AVCapturePhotoSettings()
        
        // Ensure connection is properly set based on current orientation
        if let photoOutputConnection = output.connection(with: .video) {
            photoOutputConnection.videoOrientation = getVideoOrientation()
        }
        
        output.capturePhoto(with: settings, delegate: self)
    }
    
    private func getVideoOrientation() -> AVCaptureVideoOrientation {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .portrait
        }
        
        let orientation = windowScene.interfaceOrientation
        
        switch orientation {
        case .landscapeLeft:
            return .landscapeRight
        case .landscapeRight:
            return .landscapeLeft
        case .portraitUpsideDown:
            return .portraitUpsideDown
        default:
            return .portrait
        }
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput,
                     didFinishProcessingPhoto photo: AVCapturePhoto,
                     error: Error?) {
        guard let data = photo.fileDataRepresentation(),
              let image = UIImage(data: data) else {
            return
        }
        
        // Draw the black circle overlay
        let finalImage = drawOverlay(on: image)
        
        DispatchQueue.main.async {
            self.capturedImage = finalImage
        }
    }
    
    private func drawOverlay(on image: UIImage) -> UIImage {
        let imageSize = image.size
        let renderer = UIGraphicsImageRenderer(size: imageSize)
        
        let finalImage = renderer.image { context in
            image.draw(at: .zero)
            let circleSize: CGFloat = min(imageSize.width, imageSize.height) * 0.5
            let circleRect = CGRect(
                x: (imageSize.width - circleSize) / 2,
                y: (imageSize.height - circleSize) / 2,
                width: circleSize,
                height: circleSize
            )
            context.cgContext.setFillColor(UIColor.yellow.withAlphaComponent(0.6).cgColor)
            context.cgContext.fillEllipse(in: circleRect)
        }
        
        return finalImage
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
