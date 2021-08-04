//
//  ViewController.swift
//  Todays_Cafe
//
//  Created by SeungMin on 2021/07/16.
//

import UIKit
import FSPagerView

class HomeViewController: UIViewController, FSPagerViewDataSource, FSPagerViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let bannerViewModel = BannerViewModel()
    let tagViewModel = TagViewModel()

    @IBOutlet weak var tagSearchBtn: UIButton! {
        didSet {
            self.tagSearchBtn.setTitle("원하는 테마를 검색해보세요!", for: .normal)
            self.tagSearchBtn.setTitleColor(.gray, for: .normal)
            self.tagSearchBtn.titleLabel?.font = .boldSystemFont(ofSize: 17)
            self.tagSearchBtn.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
            self.tagSearchBtn.contentHorizontalAlignment = .left
            self.tagSearchBtn.titleEdgeInsets.left = 30
            self.tagSearchBtn.imageEdgeInsets.left = 20
            self.tagSearchBtn.tintColor = .gray
            self.tagSearchBtn.layer.cornerRadius = 10
            self.tagSearchBtn.layer.borderWidth = 1
            self.tagSearchBtn.layer.borderColor = UIColor.darkGray.cgColor
        }
    }
    
    @IBOutlet weak var myPagerView: FSPagerView! {
        didSet {
            self.myPagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
            self.myPagerView.itemSize = FSPagerViewAutomaticSize
            self.myPagerView.automaticSlidingInterval = 4.0
//            self.myPagerView.isInfinite = true
        }
    }
    
    @IBOutlet weak var myPageControl: FSPageControl! {
        didSet {
            self.myPageControl.numberOfPages = self.bannerViewModel.countBannerList
            self.myPageControl.contentHorizontalAlignment = .center
            self.myPageControl.itemSpacing = 15
//            self.myPageControl.backgroundColor = .gray
//            self.myPageControl.interitemSpacing = 16
        }
    }
    
    // MARK: - ViewDidLoad 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myPagerView.dataSource = self
        self.myPagerView.delegate = self
    }
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return self.bannerViewModel.countBannerList
    }
    
    // MARK: - PagerView
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.image = UIImage(named: self.bannerViewModel.bannerInfo(at: index).bannerImageName)
        cell.textLabel?.text = self.bannerViewModel.bannerInfo(at: index).bannerText
        cell.textLabel?.numberOfLines = 2
        return cell
    }

    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        self.myPageControl.currentPage = targetIndex
    }
    
    func pagerViewDidEndScrollAnimation(_ pagerView: FSPagerView) {
        self.myPageControl.currentPage = pagerView.currentIndex
    }
    
    func pagerView(_ pagerView: FSPagerView, shouldHighlightItemAt index: Int) -> Bool {
        return false
    }
    
    // MARK: - CollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tagViewModel.countTagList
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tagCollectionViewCell", for: indexPath) as? TagCollectionViewCell else {
            return UICollectionViewCell()
        }
        let tagInfo = tagViewModel.tagInfo(at: indexPath.item)
        cell.update(tagInfo: tagInfo)
        return cell
    }
}
