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
    let pad: CGFloat = 15
    
    // subclasses are sharing these attributes
    let center = (NSParagraphStyleAttributeName, {() -> Any in let p = NSMutableParagraphStyle(); p.alignment = .center; return p }())
    let headerCenterWithSpacing = (NSParagraphStyleAttributeName, {() -> Any in let p = NSMutableParagraphStyle(); p.alignment = .center; p.paragraphSpacing = 4; return p }())
    let headerFont = (NSFontAttributeName, NSFont(name: "Arial", size: 22.0) as Any)
    let textFont = (NSFontAttributeName, NSFont(name: "Arial", size: 14.0) as Any)
    let headerColor = (NSForegroundColorAttributeName, NSColor.wetAsphalt() as Any)
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init() {
        // using desired convenience initializer
        let temp = NSTextView(frame: NSZeroRect)
        
        // using designated initializer, as required by the compiler
        super.init(frame: temp.frame, textContainer: temp.textContainer)
        
        // setup
        self.register(forDraggedTypes: [NSFilenamesPboardType])
        textContainerInset = NSSize(width: pad, height: pad)
        isEditable = false
        
        // setup border to show selection
        wantsLayer = true
        layer?.borderColor = NSColor.selectedControlColor.cgColor

    }

    override var intrinsicContentSize:NSSize {
        let size = attributedString().size()
        return NSMakeSize(size.width + 2*pad, size.height + 2*pad)
    }
    
    var isReceivingDrag = false {
        didSet {
            if isReceivingDrag == true {
                layer?.borderWidth = 5.0
            } else {
                layer?.borderWidth = 0
            }
            Swift.print("isReceivingDrag")
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
            } else if let window = self.window {
                let alert = NSAlert()
                alert.messageText = "Use a PDF"
                alert.addButton(withTitle: "OK")
                alert.beginSheetModal(for: window, completionHandler: nil )
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


