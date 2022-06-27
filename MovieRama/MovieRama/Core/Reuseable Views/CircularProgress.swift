//
//  Copyright © 2022 Panagiotis Mourgias
//  All rights reserved.
//

import UIKit

class CircularProgress: UIView {
    
    // MARK: Properties
    
    private var progressLayer = CAShapeLayer()
    private var trackLayer = CAShapeLayer()
    
    private let titleLabel = UILabel()
    
    private var trackProgress: Double = 0.0
    
    // MARK: Draw
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        makeCircularPath()
    }
    
    // MARK: Setup View
    
    private func setupLabel() {
        addSubview(titleLabel)
        titleLabel.layout(
            .center(0)
        )
    }
    
    // MARK: Setup Circular Path
    
    func makeCircularPath() {
        self.backgroundColor = .clear
        
        self.layer.cornerRadius = frame.size.width / 2
        
        let circelPath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width/2, y: frame.size.height/2),
                                      radius: (frame.size.width - 1.5)/2,
                                      startAngle: CGFloat(-0.5 * .pi),
                                      endAngle: CGFloat(1.5 * .pi),
                                      clockwise: true)
        
        trackLayer.path = circelPath.cgPath
        trackLayer.fillColor = UIColor.darkGray.cgColor
        trackLayer.strokeColor = UIColor.darkGray.cgColor // <- track color
        
        trackLayer.lineWidth = 8
        trackLayer.strokeEnd = 1.0
        trackLayer.lineCap = .round
        
        layer.addSublayer(trackLayer)
        
        progressLayer.path = circelPath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = UIColor.yellow.cgColor // <- progress color
        
        progressLayer.lineWidth = 2
        progressLayer.strokeEnd = trackProgress
        progressLayer.lineCap = .round
        
        layer.addSublayer(progressLayer)
        
        setupLabel()
    }
    
    // MARK: Set - Update Circular Path
    
    func setProgress(_ value: Double, label: String, size: CGFloat = 12) {
        
        // Updates in main thread
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            // Disable implicit animations at start
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            
            // Keep reference when the view going to redraw
            self.trackProgress = CGFloat(value / 10)
            
            self.progressLayer.strokeEnd = self.trackProgress
            self.updateTrackColor(value / 10)
            CATransaction.commit()
        }
        
        self.titleLabel.attributedText = label.style(font: .medium, size: size)
    }
    
    // MARK: Update Track Color
    
    private func updateTrackColor(_ value: Double) {
        
        var color: UIColor = .red // initial color
        
        if value > 0.75 {
            color = UIColor.green
            
        } else if value > 0.5 {
            color = UIColor.yellow
            
        } else {
            color = UIColor.red
        }
        
        progressLayer.strokeColor = color.cgColor
    }
}
