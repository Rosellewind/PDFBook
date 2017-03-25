//
//  Drop.swift
//  PDFBook
//
//  Created by Roselle Tanner on 3/19/17.
//  Copyright © 2017 Roselle Tanner. All rights reserved.
//

import Cocoa
import Quartz

// print settings: 2-sided, layout- 4 per page, long edged binding

class DropView: NSView {
    var isReceivingDrag = false {
        didSet {
            needsDisplay = true
        }
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        if isReceivingDrag {
            NSColor.selectedControlColor.set()
            
            let path = NSBezierPath(rect:bounds)
            path.lineWidth = 5.0
            path.stroke()
        }    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        Swift.print("init")
        self.register(forDraggedTypes: [NSFilenamesPboardType])
    }
    
    override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
        Swift.print("draggingEntered")
        return NSDragOperation.copy
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
        
        // Get the pasteboard
        
        let pboard = sender.draggingPasteboard()
        
        
        // Make sure that there are filenames in the pasteboard
        if let urls = pboard.readObjects(forClasses: [NSURL.self], options:nil) as? [URL], urls.count > 0 {
            
            // create the pdf
            if let pdf = PDFDocument(url: urls[0]), let page = pdf.page(at:0), let newPdf = PDFDocument(data: page.dataRepresentation) {
                newPdf.removePage(at: 0)
                makeSmallBooket(from: pdf, to: newPdf)
                let printInfo = NSPrintInfo()
                newPdf.printOperation(for: printInfo, scalingMode: .pageScaleNone, autoRotate: false)?.run()
            }
            
            return true
        }
        
        // Still here, then something went wrong. The drop is not accepted.
        
        return false
        
    }
    
    func makeSmallBooket(from: PDFDocument, to: PDFDocument) {
        
        // add blank pages at the end
        let blankPages = 8 - from.pageCount % 8
        if blankPages < 8 {
            for _ in 0..<blankPages{
                from.insert(PDFPage(), at: from.pageCount)
            }
        }
        
        
        let endIndex = from.pageCount - 1
        let numPrintedPages = from.pageCount / 4
        
        for i in 0..<numPrintedPages {
            let base = Int(4*((i+2)/2))
            var zero: Int
            var one: Int
            var two: Int
            var three: Int
            if i%2 == 0 {   // if even
                zero = base - 1
                one = endIndex - base + 1
                two = base - 3
                three = endIndex - base + 3
            } else {
                zero = endIndex - base + 2
                one = base - 2
                two = endIndex - base + 4
                three = base - 4
            }
            to.insert(from.page(at: zero)!, at: to.pageCount)
            to.insert(from.page(at: one)!, at: to.pageCount)
            to.insert(from.page(at: two)!, at: to.pageCount)
            to.insert(from.page(at: three)!, at: to.pageCount)
        }
    }
    
}
