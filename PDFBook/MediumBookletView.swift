//
//  MediumBookletView.swift
//  PDFBook
//
//  Created by Roselle Tanner on 3/25/17.
//  Copyright © 2017 Roselle Tanner. All rights reserved.
//

import Cocoa
import Quartz

class MediumBookletView: DropIntoView {
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init() {
        super.init()
        backgroundColor = NSColor.emerald()
        if let layoutManager = layoutManager {
            let color = (NSForegroundColorAttributeName, NSColor.clouds() as Any)
            
            let headerAttributes = Dictionary<String, Any>.withElements([headerCenterWithSpacing, headerFont, headerColor])
            let secondHeaderAttributes = Dictionary<String, Any>.withElements([headerCenterWithSpacing, headerFont, color])
            let attributes = Dictionary<String, Any>.withElements([center, textFont, color])
            
            let headerString = NSMutableAttributedString(string: "Drop Pdf files here to print a Medium Booklet", attributes: headerAttributes)
            let firstString = NSAttributedString(string: "\n2 pages on the front and back of each sheet\n5.5 x 8.5", attributes: attributes)
            let secondHeaderString = NSMutableAttributedString(string: "\n\nUse these printer settings:", attributes: secondHeaderAttributes)
            let secondString = NSAttributedString(string: "\nCheck the 2-Sided box\nLayout/Pages Per Sheet/2\nLayout/Layout Direction/Z\nLayout/Two-Sided/Short-Edge binding", attributes: attributes)
            headerString.append(firstString)
            headerString.append(secondHeaderString)
            headerString.append(secondString)
            
            let textStorage = NSTextStorage(attributedString: headerString)
            layoutManager.replaceTextStorage(textStorage)
        }
    }
    
    override func pdfDropped(pdf: PDFDocument) {
        super.pdfDropped(pdf: pdf)
        
        // create the pdf
        if let page = pdf.page(at:0), let newPdf = PDFDocument(data: page.dataRepresentation) {
            newPdf.removePage(at: 0)
            makeMediumBooklet(from: pdf, to: newPdf)
            let printInfo = NSPrintInfo()
            newPdf.printOperation(for: printInfo, scalingMode: .pageScaleNone, autoRotate: false)?.run()
        }
    }
    
    func makeMediumBooklet(from: PDFDocument, to: PDFDocument) {
        
        // add blank pages at the end
        let blankPages = 4 - from.pageCount % 4
        if blankPages < 4 {
            for _ in 0..<blankPages{
                from.insert(PDFPage(), at: from.pageCount)
            }
        }
        
        let endIndex = from.pageCount - 1
        let numPrintedPages = from.pageCount / 2
        
        // add the new pages one at a time
        for i in 0..<numPrintedPages {
            var zero: Int
            var one: Int
            
            if i%2 == 0 {   // if even
                zero = endIndex - i
                one = i
            } else {
                zero = i
                one = endIndex - i
            }
            to.insert(from.page(at: zero)!, at: to.pageCount)
            to.insert(from.page(at: one)!, at: to.pageCount)
        }
    }
}
