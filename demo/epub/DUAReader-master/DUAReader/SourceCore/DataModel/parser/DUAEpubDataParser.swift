//
//  DUAEpubDataParser.swift
//  DUAReader
//
//  Created by mengminduan on 2017/12/27.
//  Copyright © 2017年 nothot. All rights reserved.
//

import UIKit
import DTCoreText

class DUAEpubDataParser: DUADataParser {
    
    override func parseChapterFromBook(path: String, completeHandler: @escaping (Array<String>, Array<DUAChapterModel>) -> Void) {
        let epubZippedPath = DUAUtils.unzipWith(filePath: path)
        let opfPath = DUAUtils.OPFPathFrom(epubPath: epubZippedPath)
        let chapterInfoArray = DUAUtils.parseOPF(opfPath: opfPath)
        var titleArray: [String] = []
        var models: [DUAChapterModel] = []
        
        var chapterIndexOffset = false
        if Int(chapterInfoArray.first!["chapterIndex"]!)! == 0 {
            chapterIndexOffset = true
        }
        
        for item in chapterInfoArray {
            titleArray.append(item["chapterTitle"]!)
            let chapter = DUAChapterModel()
            chapter.chapterIndex = chapterIndexOffset ? Int(item["chapterIndex"]!)! + 1 : Int(item["chapterIndex"]!)!
            chapter.path = item["chapterPath"]
            chapter.title = item["chapterIndex"]
            models.append(chapter)
        }
        completeHandler(titleArray, models)
    }
    
    override func attributedStringFromChapterModel(chapter: DUAChapterModel, config: DUAConfiguration) -> NSAttributedString? {
        
        
        
        
        
        
//        let htmlData = try? Data.init(contentsOf: URL.init(fileURLWithPath: chapter.path!))
        
                
        
        //    NSURL *htmlUrl = [NSURL URLWithString:@"http://192.168.1.154:18082/epub/%E6%AF%8F%E5%A4%A9%E6%87%82%E4%B8%80%E7%82%B9%E5%A5%BD%E7%8E%A9%E5%BF%83%E7%90%86%E5%AD%A6/OPS/chapter40.html"];

        let string = "http://192.168.1.154:18082/epub/%E6%AF%8F%E5%A4%A9%E6%87%82%E4%B8%80%E7%82%B9%E5%A5%BD%E7%8E%A9%E5%BF%83%E7%90%86%E5%AD%A6/OPS/chapter40.html";
        
        let basestring = "http://192.168.1.154:18082/epub/%E6%AF%8F%E5%A4%A9%E6%87%82%E4%B8%80%E7%82%B9%E5%A5%BD%E7%8E%A9%E5%BF%83%E7%90%86%E5%AD%A6/OPS/";

        
        
        
        let htmlData = try? Data.init(contentsOf: URL.init(string: string)!)

        
        //        let myString = try? String.init(contentsOf: URL.init(string: "https://zhuanlan.zhihu.com/p/103392959")!)

        
        let myString = try? String.init(contentsOf: URL.init(string: string)!)
        
        debugPrint("myString======>>>\(myString ?? "0000009090")")
        
        
        let htmlText = String.init(bytes: htmlData!, encoding: String.Encoding.utf8)
        
        debugPrint("htmlText======>\(String(describing: htmlText))");
        
        if htmlData == nil {
            return nil
        }

//        let options = [
//            DTDefaultFontFamily : "Times New Roman",
//            DTDefaultLinkColor  : "purple",
//            NSTextSizeMultiplierDocumentOption : 1.0,
//            DTDefaultFontSize   : config.fontSize,
//            DTDefaultLineHeightMultiplier : config.lineHeightMutiplier,
//            DTDefaultTextAlignment : "0",
//            DTDefaultHeadIndent : "0.0",
//            NSBaseURLDocumentOption : URL.init(fileURLWithPath: chapter.path!),
//            DTMaxImageSize      : config.contentFrame.size,
//            ] as [String : Any]

        
        let options = [
                   DTDefaultFontFamily : "Times New Roman",
                   DTDefaultLinkColor  : "purple",
                   NSTextSizeMultiplierDocumentOption : 1.0,
                   DTDefaultFontSize   : config.fontSize,
                   DTDefaultLineHeightMultiplier : config.lineHeightMutiplier,
                   DTDefaultTextAlignment : "0",
                   DTDefaultHeadIndent : "0.0",
                   
                   NSBaseURLDocumentOption : URL.init(string: basestring)!,

                   DTMaxImageSize      : config.contentFrame.size,
                   ] as [String : Any]

        
        //https://pic4.zhimg.com/v2-b03c37ed1646047b20d5e2ef943b5ff7_b.jpg
        
        let attrString: NSAttributedString? = NSAttributedString.init(htmlData: htmlData, options: options, documentAttributes: nil)

        return attrString
    }
}
