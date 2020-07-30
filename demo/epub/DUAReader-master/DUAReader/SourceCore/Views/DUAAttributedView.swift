//
//  DUAAttributedView.swift
//  DUAReader
//
//  Created by mengminduan on 2018/1/15.
//  Copyright © 2018年 nothot. All rights reserved.
//

import UIKit
import DTCoreText

class DUAAttributedView: DTAttributedLabel, UIGestureRecognizerDelegate, DTAttributedTextContentViewDelegate, DTLazyImageViewDelegate {

    var longPressGes: UILongPressGestureRecognizer
    
    var panGes: UIPanGestureRecognizer
    
    var tapGes: UITapGestureRecognizer
    
    var selectedLineArray: [CGRect] = []
    
    
    var hitRange: NSRange
    
    var touchLeft: Bool = false
    
    var leftCursor = CGRect()
    
    var rightCursor = CGRect()
    
    var touchIsValide = false
    
    var convexView: DUAConVexLensView?
    
    
    
    override init(frame: CGRect) {
        // 属性赋值
        self.longPressGes = UILongPressGestureRecognizer()
        self.panGes = UIPanGestureRecognizer()
        self.tapGes = UITapGestureRecognizer()
        self.hitRange = NSRange()
        
        // 父类初始化
        super.init(frame: frame)
        
        self.longPressGes = UILongPressGestureRecognizer.init(target: self, action: #selector(handleLongPressGesture(gesture:)))

        self.addGestureRecognizer(self.longPressGes)
        
        self.panGes = UIPanGestureRecognizer.init(target: self, action: #selector(handlePanGesture(gesture:)))
        self.addGestureRecognizer(self.panGes)
        
        
        self.backgroundColor = UIColor.red
        
        self.panGes.delegate = self
        self.delegate = self
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
//        super.init(coder: aDecoder)
    }
    
    func attributedTextContentView(_ attributedTextContentView: DTAttributedTextContentView!, viewFor attachment: DTTextAttachment!, frame: CGRect) -> UIView! {
//        let url = attachment.contentURL;
        
        
        debugPrint("frame===frame==>>>>\(frame)")
        
        let imageView: DTLazyImageView = DTLazyImageView.init(frame: CGRect(x: 10, y: 20, width: 100, height: 200));
        imageView.url = attachment.contentURL;
        imageView.contentMode = .scaleAspectFit
        
//        imageView.url = URL(string: imageString);

        imageView.image = (attachment as? DTImageTextAttachment)?.image
        imageView.delegate = self
        imageView.backgroundColor = .red
        return imageView;
        
    }
    
    func lazyImageView(_ lazyImageView: DTLazyImageView!, didChangeImageSize size: CGSize) {
        
        /**
         
         NSURL *url = lazyImageView.url;
            CGSize imageSize = size;
            NSPredicate *pred = [NSPredicate predicateWithFormat:@"contentURL == %@", url];
            BOOL didUpdate = NO;
            
            //update all attachments that match this URL (possibly multiple images with same size)
            //更新所有匹配URL的占位符视图
            for (DTTextAttachment *oneAttachment in [self.attributedLabel.layoutFrame textAttachmentsWithPredicate:pred]){
                //update attachments that have no original size, that also sets the display size
                //更新没有自带尺寸的占位视图(如网络图片)
                if (CGSizeEqualToSize(oneAttachment.originalSize, CGSizeZero)){
                    //原始图片不带宽高，被识别后修改Html
                    oneAttachment.originalSize = imageSize;
                  //使用新拿到的图片尺寸更新HTML字符串
                    [self configNoSizeImageView:url.absoluteString size:imageSize];
                    didUpdate = YES;
                }
            }
            if (didUpdate){
                //重新显示富文本
                CGSize textSize = [self getAttributedTextHeightHtml:self.html with_viewMaxRect:_viewMaxRect];
                self.attributedLabel.frame = CGRectMake(_viewMaxRect.origin.x, _viewMaxRect.origin.y, _viewMaxRect.size.width, textSize.height);
                self.attributedLabel.attributedString = [self getAttributedStringWithHtml:self.html];
                self.attributedLabel.layouter = nil;
                [self.attributedLabel relayoutText];
            }
         
         */
        
        let url = lazyImageView.url;
        let imageSize = size;
        
      //  let pred = NSPredicate(format: "contentURL == \(url)", argumentArray: nil)
//        for oneAttachment in self.layoutFrame.textAttachments(with: pred) {
//
//        }
        
        
        
        
        
    }
    
    
    
    
    //    MARK: gesture handler
    
    @objc func handleLongPressGesture(gesture: UILongPressGestureRecognizer) -> Void {
        let hitPoint = gesture.location(in: gesture.view)
        
        if gesture.state == .began {
            let hitIndex = self.closestCursorIndex(to: hitPoint)
            hitRange = self.locateParaRangeBy(index: hitIndex)
            selectedLineArray = self.lineArrayFrom(range: hitRange)
            self.setNeedsDisplay(self.bounds)
            showMenuItemView()
        }
        if gesture.state == .ended {
            tapGes = UITapGestureRecognizer.init(target: self, action: #selector(handleTapGes(gesture:)))
            self.addGestureRecognizer(tapGes)
        }
        
    }
    
    @objc func handlePanGesture(gesture: UIPanGestureRecognizer) -> Void {
        let hitPoint = gesture.location(in: gesture.view)
        
        if gesture.state == .began {
            let leftRect = CGRect(x: leftCursor.minX - 20, y: leftCursor.minY - 20, width: leftCursor.width + 40, height: leftCursor.height + 40)
            let rightRect = CGRect(x: rightCursor.minX - 20, y: rightCursor.minY - 20, width: rightCursor.width + 40, height: rightCursor.height + 40)
            if leftRect.contains(hitPoint) {
                touchIsValide = true
                touchLeft = true
            }
            else if rightRect.contains(hitPoint) {
                touchIsValide = true
                touchLeft = false
            }else {
                handleTapGes(gesture: nil)
            }
        }
        else if gesture.state == .changed {
            if touchIsValide {
                hideMenuItemView()
                showConvexLensView(point: hitPoint)
                self.convexView?.locatePoint = hitPoint
                self.updateHitRangeWith(point: hitPoint, touchIsLeft: touchLeft)
                selectedLineArray = self.lineArrayFrom(range: hitRange)
                self.setNeedsDisplay(self.bounds)
            }
        }
        else {
            if touchIsValide {
                hideConvexLensView()
                showMenuItemView()
                touchIsValide = false
            }
        }
        
    }
    
    @objc func handleTapGes(gesture: UITapGestureRecognizer?) -> Void {
        selectedLineArray.removeAll()
        self.setNeedsDisplay()
        self.removeGestureRecognizer(tapGes)
        
        hideMenuItemView()
    }
    
    //    MARK: draw
    

    override func draw(_ layer: CALayer, in ctx: CGContext) {
        super.draw(layer, in: ctx)
        
        self.drawSelectedLines(context: ctx)
    }
    
    func drawSelectedLines(context: CGContext?) -> Void {
        if selectedLineArray.isEmpty {
            return
        }
        
        let path = CGMutablePath()
        for item in selectedLineArray {
            path.addRect(item)
        }
        let color = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        
        context?.setFillColor(color.cgColor)
        context?.addPath(path)
        context?.fillPath()
        
//        save left and roght cursor location
        let firstRect = selectedLineArray.first!
        leftCursor = CGRect(x: firstRect.origin.x - 4, y: firstRect.origin.y, width: 4, height: firstRect.size.height)
        let lastRect = selectedLineArray.last!
        rightCursor = CGRect(x: lastRect.maxX, y: lastRect.origin.y, width: 4, height: lastRect.size.height)
        
//        draw cursor
        context?.addRect(leftCursor)
        context?.addRect(rightCursor)
        context?.addEllipse(in: CGRect(x: leftCursor.midX - 3, y: leftCursor.origin.y - 6, width: 6, height: 6))
        context?.addEllipse(in: CGRect(x: rightCursor.midX - 3, y: rightCursor.maxY, width: 6, height: 6))
        context?.setFillColor(UIColor.black.cgColor)
        context?.fillPath()
    
    }

    
    //    MARK: utils
    
    func locateParaRangeBy(index: Int) -> NSRange {
        var targetRange = NSRange()
        for item in self.layoutFrame.paragraphRanges {
            let paraRange: NSRange = item as! NSRange
            if index >= paraRange.location && index < paraRange.location + paraRange.length {
                //                找到hit段落
                targetRange = paraRange
                break
            }
        }
        return targetRange
    }
    
    func lineArrayFrom(range: NSRange) -> [CGRect] {
        var lineArray: [CGRect] = []
        var line = self.layoutFrame.lineContaining(UInt(range.location))
        let selectedMaxIndex = range.location + range.length
        var startIndex = range.location
        
        while line!.stringRange().location < selectedMaxIndex {
            let lineMaxIndex = line!.stringRange().location + line!.stringRange().length
            let startX = line!.frame.origin.x + line!.offset(forStringIndex: startIndex)
            let lineEndOffset = lineMaxIndex <= selectedMaxIndex ? line?.offset(forStringIndex: lineMaxIndex) : line?.offset(forStringIndex: selectedMaxIndex)
            let endX = line!.frame.origin.x + lineEndOffset!
            let rect = CGRect(x: startX, y: line!.frame.origin.y, width: endX - startX, height: line!.frame.size.height)
            lineArray.append(rect)
            
//            update line ,startIndex
            startIndex = lineMaxIndex
            line = self.layoutFrame.lineContaining(UInt(startIndex))
            if lineMaxIndex == selectedMaxIndex || line == nil {
                break
            }
            
        }
        
        return lineArray
    }
    
    func updateHitRangeWith(point: CGPoint, touchIsLeft: Bool) -> Void {
        let hitIndex = self.layoutFrame.closestCursorIndex(to: point)
        
        if touchIsLeft {
            if hitIndex >= hitRange.location + hitRange.length {
                return
            }
            hitRange = NSRange.init(location: hitIndex, length: hitRange.location + hitRange.length - hitIndex)
        }else {
            if hitIndex <= hitRange.location {
                return
            }
            hitRange = NSRange.init(location: hitRange.location, length: hitIndex - hitRange.location)
        }
        
    }
    
    func showMenuItemView() -> Void {
        self.becomeFirstResponder()
        let menuController = UIMenuController.shared
        let copyItem = UIMenuItem.init(title: "复制", action: #selector(onCopyItemClicked))
        let noteItem = UIMenuItem.init(title: "笔记", action: #selector(onNoteItemClicked))
        menuController.menuItems = [copyItem, noteItem]
        var rect: CGRect = CGRect()
        if selectedLineArray.first != nil {
            rect = selectedLineArray.first!
        }
        menuController.setTargetRect(rect, in: self)
        menuController.setMenuVisible(true, animated: true)
    }
    
    func hideMenuItemView() -> Void {
        let menuController = UIMenuController.shared
        menuController.setMenuVisible(false, animated: true)
        self.resignFirstResponder()
    }
    
    func showConvexLensView(point: CGPoint) -> Void {
        if self.convexView == nil {
            self.convexView = DUAConVexLensView()
            UIApplication.shared.keyWindow?.addSubview(self.convexView!)
        }
    }
    
    func hideConvexLensView() -> Void {
        if convexView != nil {
            self.convexView?.removeFromSuperview()
            self.convexView = nil
        }
    }
    
    
    //    MARK: gesture delegate
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer is UIPanGestureRecognizer {
            let hitPoint = gestureRecognizer.location(in: gestureRecognizer.view)
            let leftRect = CGRect(x: leftCursor.minX - 20, y: leftCursor.minY - 20, width: leftCursor.width + 40, height: leftCursor.height + 40)
            let rightRect = CGRect(x: rightCursor.minX - 20, y: rightCursor.minY - 20, width: rightCursor.width + 40, height: rightCursor.height + 40)
            if !leftRect.contains(hitPoint) && !rightRect.contains(hitPoint) {
                return true
            }
        }
        
        return false
    }
    
    //    MARK: menu item click method
    @objc func onCopyItemClicked() -> Void {
        let pageContent = self.attributedString.string
        let startIndex = pageContent.index(pageContent.startIndex, offsetBy: hitRange.location)
        var endIndex = pageContent.index(startIndex, offsetBy: hitRange.length)
        if pageContent.endIndex <= endIndex {
            endIndex = pageContent.index(before: endIndex)
        }
        let slice = pageContent[startIndex...endIndex]
        print("当前选中范围 \(hitRange)  选中内容 \(slice)")
        
        self.resignFirstResponder()
        
        selectedLineArray.removeAll()
        self.setNeedsDisplay()
        self.removeGestureRecognizer(tapGes)
    }
    
    @objc func onNoteItemClicked() -> Void {
        let pageContent = self.attributedString.string
        let startIndex = pageContent.index(pageContent.startIndex, offsetBy: hitRange.location)
        var endIndex = pageContent.index(startIndex, offsetBy: hitRange.length)
        if pageContent.endIndex <= endIndex {
            endIndex = pageContent.index(before: endIndex)
        }
        let slice = pageContent[startIndex...endIndex]
        print("当前选中范围 \(hitRange)  选中内容 \(slice)")
        
        self.resignFirstResponder()
        
        selectedLineArray.removeAll()
        self.setNeedsDisplay()
        self.removeGestureRecognizer(tapGes)
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
}
