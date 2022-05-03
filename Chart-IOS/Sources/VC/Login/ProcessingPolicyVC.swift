//
//  ProcessingPolicyVC.swift
//  Chart-IOS
//
//  Created by 김대희 on 2022/05/03.
//

import UIKit
import PDFKit

class ProcessingPolicyVC: BaseViewController {
    
    let pdfView = PDFView().then {
        $0.autoScales = true
        $0.backgroundColor = Asset.backgroundColor.color
        $0.displayMode = .singlePageContinuous
        $0.displayDirection = .vertical
    }
    
    override func configureUI() {
        view.addSubview(pdfView)
        pdfView.document = createPdfDocument()
    }
    
    override func setupConstraints() {
        pdfView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func resourceUrl(forFileName fileName: String) -> URL? {
        if let resourceUrl = Bundle.main.url(forResource: fileName, withExtension: "pdf") {
            return resourceUrl
        }
        return nil
    }
    
    private func createPdfDocument() -> PDFDocument? {
        if let resourceUrl = resourceUrl(forFileName: "processing_policy") {
            print(resourceUrl)
            return PDFDocument(url: resourceUrl)
        }
        return nil
    }
    
}
