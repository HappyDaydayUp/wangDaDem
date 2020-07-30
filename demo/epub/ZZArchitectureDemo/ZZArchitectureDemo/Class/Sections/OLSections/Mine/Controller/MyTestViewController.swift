//
//  MyTestViewController.swift
//  ZZArchitectureDemo
//
//  Created by 网达 on 2020/5/28.
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

class MyTestViewController: UIViewController {

    let btn = UIButton(frame: CGRect(x: 50, y: 50, width: 50, height: 50))
    
    let folioReader = FolioReader()

    lazy var newBtn: UIButton = {
        let btn = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        btn.backgroundColor = .blue
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.backgroundColor = .systemRed
        
        view.addSubview(newBtn)
        
        view.addSubview(btn)
        btn.backgroundColor = .darkGray
        
        newBtn.addTarget(self, action: #selector(newBtnClick), for: .touchUpInside)
        
        
     //   btn.addTarget(<#T##target: Any?##Any?#>, action: <#T##Selector#>, for: <#T##UIControl.Event#>)
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
       // folioReader.presentReader(parentViewController: self, withEpubPath: bookPath, andConfig: readerConfiguration, shouldRemoveEpub: false)
        
        
        
        
        let show = FolioReaderContainer(withConfig: readerConfiguration, folioReader: folioReader, epubPath: bookPath);
        
        show.modalPresentationStyle = .fullScreen;
        
        self.present(show, animated: true);
        
    }

    
    private func setCover(_ button: UIButton?, index: Int) {
           guard
               let epub = Epub(rawValue: index),
               let bookPath = epub.bookPath else {
                   return
           }

           do {
               let image = try FolioReader.getCoverImage(bookPath)

               button?.setBackgroundImage(image, for: .normal)
           } catch {
               print(error.localizedDescription)
           }
       }

    
    
    @objc func newBtnClick() {
        
               
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
