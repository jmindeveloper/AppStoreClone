//
//  extension.swift
//  AppStoreClone
//
//  Created by J_Min on 2022/06/07.
//

import UIKit
import SnapKit

// UIButton
extension UIButton {
    func setDownloadButton() {
        self.backgroundColor = .systemGray4
        self.layer.cornerRadius = 15
        self.setTitleColor(UIColor.systemBlue, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
    }
}

final class Divider: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemGray4
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// UIImage
extension UIImage {
    func getAverageColor(completion: @escaping (UIColor) -> Void) {
        
        DispatchQueue.global().async {
            // image crop
            let imageWidth = self.size.width
            let imageHeight = self.size.height
//            let imageSize = self.size
            let yOffset = (imageHeight) / 5
            
            let cropRect = CGRect(x: 0,
                                  y: imageHeight - (yOffset * 2),
                                  width: imageWidth,
                                  height: yOffset).integral
            let sourceCGImage = self.cgImage!
            let croppedImage = UIImage(cgImage: sourceCGImage.cropping(to: cropRect)!)
            
            guard let inputImage = CIImage(image: croppedImage) else { return }
            // A CIVector object representing the rectangular region of inputImage .
            let extentVector = CIVector(x: inputImage.extent.origin.x, y: inputImage.extent.origin.y, z: inputImage.extent.size.width, w: inputImage.extent.size.height)
            
            guard let filter = CIFilter(name: "CIAreaAverage", parameters: [kCIInputImageKey: inputImage, kCIInputExtentKey: extentVector]) else { return }
            guard let outputImage = filter.outputImage else { return }

            var bitmap = [UInt8](repeating: 0, count: 4)
            let context = CIContext(options: [.workingColorSpace: kCFNull as Any])
            context.render(outputImage, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: .RGBA8, colorSpace: nil)
            DispatchQueue.main.async {
                completion(UIColor(red: CGFloat(255 - bitmap[0]) / 255, green: CGFloat(255 - bitmap[1]) / 255, blue: CGFloat(255 - bitmap[2]) / 255, alpha: CGFloat(bitmap[3]) / 255))
            }
        }
    }
}
