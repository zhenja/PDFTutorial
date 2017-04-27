//
//  ViewController.swift
//  PDFTutorial
//
//  Created by Eugen Ackermann on 11.04.17.
//  Copyright © 2017 ilume informatik ag. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let fileName = "myPdf.pdf"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pdfGenService = PDFGeneratorService(filename: fileName)
        pdfGenService.drawPdf()
        showPdfFile()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func showPdfFile() {
        
        let path        = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
        let pdfFileName = (path as NSString).appendingPathComponent(fileName)
        
        let webView     = UIWebView(frame: view.bounds)
        let url         = NSURL(fileURLWithPath: pdfFileName)
        let request     = NSURLRequest(url: url as URL)
        
        webView.scalesPageToFit = true
        webView.loadRequest(request as URLRequest)
        
        view.addSubview(webView)
    }


}

