//
//  MyViewController.swift
//  ZZArchitectureDemo
//
//  Created by 网达 on 2020/6/1.
//  Copyright © 2020 oldliu. All rights reserved.
//

import UIKit

import FolioReaderKit


enum Epub: Int {
    case bookOne = 0
    case bookTwo

    var name: String {
        switch self {
        case .bookOne:      return "The Silver Chair" // standard eBook
        case .bookTwo:      return "The Adventures Of Sherlock Holmes - Adventure I" // audio-eBook
        }
    }

    var shouldHideNavigationOnTap: Bool {
        switch self {
        case .bookOne:      return false
        case .bookTwo:      return true
        }
    }

    var scrollDirection: FolioReaderScrollDirection {
        switch self {
        case .bookOne:      return .vertical
        case .bookTwo:      return .horizontal
        }
    }

    var bookPath: String? {
        return Bundle.main.path(forResource: self.name, ofType: "epub")
    }

    var readerIdentifier: String {
        switch self {
        case .bookOne:      return "READER_ONE"
        case .bookTwo:      return "READER_TWO"
        }
    }
}


class MyViewController: UIViewController {

//    self.bookOne?.tag = Epub.bookOne.rawValue

    let folioReader = FolioReader()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .blue;
        
        
    }
    
    
     private func readerConfiguration(forEpub epub: Epub) -> FolioReaderConfig {
            let config = FolioReaderConfig(withIdentifier: epub.readerIdentifier)
            config.shouldHideNavigationOnTap = epub.shouldHideNavigationOnTap
            config.scrollDirection = epub.scrollDirection

            // See more at FolioReaderConfig.swift
    //        config.canChangeScrollDirection = false
    //        config.enableTTS = false
    //        config.displayTitle = true
    //        config.allowSharing = false
    //        config.tintColor = UIColor.blueColor()
    //        config.toolBarTintColor = UIColor.redColor()
    //        config.toolBarBackgroundColor = UIColor.purpleColor()
    //        config.menuTextColor = UIColor.brownColor()
    //        config.menuBackgroundColor = UIColor.lightGrayColor()
    //        config.hidePageIndicator = true
    //        config.realmConfiguration = Realm.Configuration(fileURL: FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("highlights.realm"))

            // Custom sharing quote background
            config.quoteCustomBackgrounds = []
            if let image = UIImage(named: "demo-bg") {
                let customImageQuote = QuoteImage(withImage: image, alpha: 0.6, backgroundColor: UIColor.black)
                config.quoteCustomBackgrounds.append(customImageQuote)
            }

            let textColor = UIColor(red:0.86, green:0.73, blue:0.70, alpha:1.0)
            let customColor = UIColor(red:0.30, green:0.26, blue:0.20, alpha:1.0)
            let customQuote = QuoteImage(withColor: customColor, alpha: 1.0, textColor: textColor)
            config.quoteCustomBackgrounds.append(customQuote)

            return config
        }
    
    
    fileprivate func open(epub: Epub) {
           guard let bookPath = epub.bookPath else {
               return
           }

           let readerConfiguration = self.readerConfiguration(forEpub: epub)
           folioReader.presentReader(parentViewController: self, withEpubPath: bookPath, andConfig: readerConfiguration, shouldRemoveEpub: false)
       }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        print("touchesBegan=====>>>>")
        
        guard let epub = Epub(rawValue: 1) else {
                   return
               }
        
               
        self.open(epub: epub)
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
