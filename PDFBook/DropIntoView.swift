//
//  DropIntoView.swift
//  PDFBook
//
//  Created by Roselle Tanner on 3/25/17.
//  Copyright © 2017 Roselle Tanner. All rights reserved.
//

import Cocoa
import Quartz

class DropIntoView: NSTextView {
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init() {
        // using desired convenience initializer
        let temp = NSTextView(frame: NSZeroRect)
        
        // using designated initializer, as required by the compiler
        super.init(frame: temp.frame, textContainer: temp.textContainer)
        
        Swift.print("init")
        self.register(forDraggedTypes: [NSFilenamesPboardType])
    }

    override var intrinsicContentSize:NSSize {
        let size = attributedString().size()
        return NSMakeSize(size.width + 20, size.height + 20)
    }
    
    var isReceivingDrag = false {
        didSet {
            Swift.print("isReceivingDrag")
            needsDisplay = true
        }
    }
    
    override func draw(_ dirtyRect: NSRect) {
        backgroundColor.setFill()
        NSRectFill(dirtyRect)
        super.draw(dirtyRect)

        
        if isReceivingDrag {
            NSColor.selectedControlColor.set()
            let path = NSBezierPath(rect:bounds)
            path.lineWidth = 5.0
            path.stroke()
        }
    }

    override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
        Swift.print("draggingEntered")
        isReceivingDrag = true
        return NSDragOperation.copy
    }
    
    override func draggingExited(_ sender: NSDraggingInfo?) {
        Swift.print("draggingExited")
        isReceivingDrag = false
    }
    
    override func draggingUpdated(_ sender: NSDraggingInfo) -> NSDragOperation {
        Swift.print("draggingUpdated")
        return NSDragOperation.copy
    }
    
    override func prepareForDragOperation(_ sender: NSDraggingInfo) -> Bool {
        Swift.print("prepareForDragOperation")
        return true
    }
    
    override func performDragOperation(_ sender: NSDraggingInfo) -> Bool {
        Swift.print("performDragOperation")
        isReceivingDrag = false
        
        // Get the pasteboard
        let pboard = sender.draggingPasteboard()
        
        
        // Make sure that there are filenames in the pasteboard
        if let urls = pboard.readObjects(forClasses: [NSURL.self], options:nil) as? [URL], urls.count > 0 {
            
            // get the pdf
            if let pdf = PDFDocument(url: urls[0]) {
                pdfDropped(pdf: pdf)
            }
            return true
        }
        
        // Still here, then something went wrong. The drop is not accepted.
        
        return false
    }
    
    func pdfDropped(pdf: PDFDocument) {
        Swift.print("pdfDropped")
    }
}
