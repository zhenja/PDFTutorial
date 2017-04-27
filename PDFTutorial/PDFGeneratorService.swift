//
//  PDFGeneratorService.swift
//  PDFTutorial
//
//  Created by Eugen Ackermann on 11.04.17.
//  Copyright © 2017 ilume informatik ag. All rights reserved.
//

import UIKit

class PDFGeneratorService: NSObject {

    let pageWidth = 595
    let pageHeight = 842
    
    let styleAttributes = [NSFontAttributeName : UIFont.systemFont(ofSize: 40)]
    
    lazy var pageSizeA4: CGRect = CGRect(x:0, y:0, width:self.pageWidth, height:self.pageHeight)
    
    var filename: String
    var filepath: String = ""
    
    var context: CGContext!
    
    init(filename: String) {
        self.filename = filename
    }
    
    
    func drawPdf() {
        
        UIGraphicsBeginPDFContextToFile(getFilePath(), pageSizeA4, nil)
        
        context = UIGraphicsGetCurrentContext()
        
        for pageNumber in 1...100 {
        
            UIGraphicsBeginPDFPage()
            drawText(text: "Willkommen bei ilum:e 😎")
            drawRectangle()
            drawCircle()
            drawLogo(image: #imageLiteral(resourceName: "ilume_logo"))
            
            drawPageNumber(number: pageNumber)
        }
        
        UIGraphicsEndPDFContext()
    }
    

    private func drawText(text: String) {
        
        let contentSize = text.boundingRect(with: CGSize(width: CGFloat(pageWidth), height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, attributes: styleAttributes, context: nil)
        
        let rect = CGRect(x: pageSizeA4.midX - contentSize.midX, y: pageSizeA4.midY, width: contentSize.width, height: contentSize.height)
        
        text.draw(in: rect, withAttributes: styleAttributes)
    }
    
    private func drawLogo(image: UIImage) {
        
        image.draw(in: CGRect(
            x:pageSizeA4.midX - ((image.size.width/3)/2),
            y:40,
            width: image.size.width/3,
            height: image.size.height/3))
    }
    
    private func drawPageNumber(number: Int) {
        
        let text = String(number)
        
        let contentSize = text.boundingRect(with: CGSize(width: CGFloat(pageWidth), height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, attributes: styleAttributes, context: nil)
        
        let rect = CGRect(x: pageSizeA4.width - 50, y: pageSizeA4.height - 50, width: contentSize.width, height: contentSize.height)
        
        text.draw(in: rect, withAttributes: styleAttributes)
    }
    
    private func getFilePath() -> String {
        
        let path2 = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
        return (path2 as NSString).appendingPathComponent(filename)
    }
    
    private func drawRectangle() {
        let rect = CGRect(x: pageSizeA4.midX - 50/2, y: 300, width: 50, height: 50)
        
        context.addRect(rect)
        context.drawPath(using: .fillStroke)
    }
    
    private func drawCircle() {
        let circleRect = CGRect(x: pageSizeA4.midX - 50, y: 500, width: 100, height: 100)
        
        context.setLineWidth(2)
        context.setStrokeColor(UIColor.red.cgColor)
        context.setFillColor(UIColor.blue.cgColor)
        
        context.addEllipse(in: circleRect)
        context.drawPath(using: .fillStroke)
    }
    
}
