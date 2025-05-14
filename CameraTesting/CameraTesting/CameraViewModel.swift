//
//  CameraViewModel.swift
//  CameraTesting
//
//  Created by Franky on 10/05/25.
//

import AVFoundation
import SwiftUI

class CameraViewModel: NSObject, ObservableObject, AVCapturePhotoCaptureDelegate {
    @Published var capturedImage: UIImage?
    let session = AVCaptureSession()
    private let output = AVCapturePhotoOutput()
    private let queue = DispatchQueue(label: "camera.queue")

    func configure() {
        session.beginConfiguration()
        guard let device = AVCaptureDevice.default(for: .video),
              let input = try? AVCaptureDeviceInput(device: device),
              session.canAddInput(input),
              session.canAddOutput(output) else {
            return
        }
        session.addInput(input)
        session.addOutput(output)
        session.commitConfiguration()
        queue.async { self.session.startRunning() }
    }

    func takePhoto() {
        let settings = AVCapturePhotoSettings()
        output.capturePhoto(with: settings, delegate: self)
    }

    func photoOutput(_ output: AVCapturePhotoOutput,
                     didFinishProcessingPhoto photo: AVCapturePhoto,
                     error: Error?) {
        guard let data = photo.fileDataRepresentation(),
              let image = UIImage(data: data) else {
            return
        }

        // Now draw the black circle on top of the real camera image
        let finalImage = drawOverlay(on: image)

        DispatchQueue.main.async {
            self.capturedImage = finalImage
        }
    }

    private func drawOverlay(on image: UIImage) -> UIImage {
        let imageSize = image.size
        let renderer = UIGraphicsImageRenderer(size: imageSize)

        let finalImage = renderer.image { context in
            // 1. Draw the base photo
            image.draw(at: .zero)

            // 2. Set up overlay (black circle)
            let circleSize: CGFloat = min(imageSize.width, imageSize.height) * 0.2
            let circleRect = CGRect(
                x: (imageSize.width - circleSize) / 2,
                y: (imageSize.height - circleSize) / 2,
                width: circleSize,
                height: circleSize
            )

            context.cgContext.setFillColor(UIColor.black.withAlphaComponent(0.6).cgColor)
            context.cgContext.fillEllipse(in: circleRect)
        }

        return finalImage
    }

}
