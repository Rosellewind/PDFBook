//
//  SmallBookletView.swift
//  PDFBook
//
//  Created by Roselle Tanner on 3/25/17.
//  Copyright © 2017 Roselle Tanner. All rights reserved.
//

import Cocoa
import Quartz

class SmallBookletView: DropIntoView {
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init() {
        super.init()
        backgroundColor = NSColor.red

        if let layoutManager = layoutManager {
            let paragraph = NSMutableParagraphStyle()
            paragraph.alignment = .center
            
            
            
            let string = NSMutableAttributedString(string: "Drop Pdf files here to print a Small Booklet", attributes: [NSForegroundColorAttributeName: NSColor.blue, NSFontAttributeName: NSFont(name: "Chalkduster", size: 18.0)!, NSParagraphStyleAttributeName: paragraph])
            let attrString = NSAttributedString(string: "\n Attributed Strings", attributes: [NSForegroundColorAttributeName: NSColor.orange, NSFontAttributeName: NSFont(name: "Chalkduster", size: 18.0)!, NSParagraphStyleAttributeName: paragraph])
            
            
            string.append(attrString)
            let textStorage = NSTextStorage(attributedString: string)
            layoutManager.replaceTextStorage(textStorage)
        }
    }
    
    override func pdfDropped(pdf: PDFDocument) {
        super.pdfDropped(pdf: pdf)
        
        // create the pdf
        if let page = pdf.page(at:0), let newPdf = PDFDocument(data: page.dataRepresentation) {
            newPdf.removePage(at: 0)
            makeSmallBooket(from: pdf, to: newPdf)
            let printInfo = NSPrintInfo()
            newPdf.printOperation(for: printInfo, scalingMode: .pageScaleNone, autoRotate: false)?.run()
        }
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
        
        // add the new pages one at a time
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
