//
//  PaintingScrollView.swift
//  CatalogueOfPaintings
//
//  Created by Vasilii Pronin on 17.02.2024.
//

import UIKit

final class PaintingScrollView: UIScrollView {
    lazy var imageView = UIImageView()
    
    private lazy var doubleTap: UITapGestureRecognizer = {
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap))
        doubleTap.numberOfTapsRequired = 2
        return doubleTap
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        delegate = self
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        contentInsetAdjustmentBehavior = .never
        decelerationRate = UIScrollView.DecelerationRate.fast
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        centerImage()
    }
    
    func set(image: UIImage) {
        imageView.removeFromSuperview()
        imageView.image = nil
        
        imageView = UIImageView(image: image)
        imageView.frame = CGRect(
            x: imageView.frame.origin.x,
            y: imageView.frame.origin.y,
            width: image.size.width,
            height: image.size.height
        )
        addSubview(imageView)
        
        configure(with: image.size)
    }
    
    private func configure(with size: CGSize) {
        self.contentSize = size
        
        setZoomScaleLimits()
        zoomScale = minimumZoomScale
        
        imageView.addGestureRecognizer(doubleTap)
        imageView.isUserInteractionEnabled = true
    }
    
    private func setZoomScaleLimits() {
        
        let xScale = bounds.size.width / imageView.bounds.width
        let yScale = bounds.size.height / imageView.bounds.height
        let minScale = min(xScale, yScale)
        self.minimumZoomScale = minScale
        
        self.zoomScale = minScale
        self.maximumZoomScale = minScale * 4
    }
    
    private func centerImage() {
        let offsetX = max((bounds.width - contentSize.width) / 2, 0)
        let offsetY = max((bounds.height - contentSize.height) / 2, 0)
        self.contentInset = UIEdgeInsets(
            top: offsetY,
            left: offsetX,
            bottom: 0,
            right: 0
        )
    }
    
    private func zoom(point: CGPoint, animated: Bool) {
        let currentScale = zoomScale
        let minScale = minimumZoomScale
        let maxScale = maximumZoomScale
        
        if minScale == maxScale && minScale > 1 {
            return
        }
        let scale = maxScale
        let finalScale = currentScale == minScale ? scale : minScale
        
        let rect = zoomRect(scale: finalScale, center: point)
        zoom(to: rect, animated: animated)
    }
    
    private func zoomRect(scale: CGFloat, center: CGPoint) -> CGRect {
        var zoomRect = CGRect.zero
        let bounds = bounds
        
        zoomRect.size.width = bounds.size.width / scale
        zoomRect.size.height = bounds.size.height / scale
        
        zoomRect.origin.x = center.x - (zoomRect.size.width / 2)
        zoomRect.origin.y = center.y - (zoomRect.size.height / 2)
        return zoomRect
    }
    
    @objc private func handleDoubleTap(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: imageView)
        zoom(point: location, animated: true)
    }
}

extension PaintingScrollView: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        centerImage()
    }
}


