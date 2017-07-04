//
//  ViewScroll.swift
//  FashionShop
//
//  Created by Minh Tuan on 7/3/17.
//  Copyright © 2017 Minh Tuan. All rights reserved.
//

import UIKit

class ViewScroll: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    var photo = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()
//        UIScrollViewDelegate
        let imgView = UIImageView(image: UIImage(named:"shop1-0.jpg"))
        imgView.frame = CGRect(x: 0, y: 0,width: imgView.frame.size.width, height: imgView.frame.size.height)
        imgView.contentMode = .scaleAspectFit
        // contentmode : dùng để xác định một khung hình được đưa ra khi biên của nó bị thay đổi
        imgView.isUserInteractionEnabled = true // dùng để tương tác giao diện với nó
        imgView.isMultipleTouchEnabled = true // để kích double
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapImg(gesture:)))
        tap.numberOfTapsRequired = 1
        imgView.addGestureRecognizer(tap)
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleTabImg(gesture:)))
        doubleTap.numberOfTapsRequired = 2
        tap.require(toFail: doubleTap) // nhan tap 1 lan
        imgView.addGestureRecognizer(doubleTap)
        scrollView.contentSize = CGSize(width: imgView.bounds.width, height: imgView.bounds.height)
        photo = imgView
        scrollView.minimumZoomScale = 0.5
        scrollView.maximumZoomScale = 2
        self.scrollView.addSubview(imgView)
       
    }
    func viewForZooming(in scrollView: UIScrollView) -> UIView?{
        return photo
    }
    func tapImg(gesture: UITapGestureRecognizer){
        let position = gesture.location(in: photo)
        zoomRectForScale(scale: scrollView.zoomScale * 1.5, center: position)
    }
    func doubleTabImg(gesture: UITapGestureRecognizer){
        let position = gesture.location(in: photo )
        zoomRectForScale(scale: scrollView.zoomScale * 0.5, center: position)
    }
    func zoomRectForScale(scale: CGFloat, center: CGPoint){
        var zoomRect = CGRect()
        let scrollViewSize = scrollView.bounds.size
        zoomRect.size.height = scrollViewSize.height / scale
        zoomRect.size.width = scrollViewSize.width / scale
        
        zoomRect.origin.x = center.x - (zoomRect.size.width / 2.0) // origin : diem goc hinh chu nhat
        zoomRect.origin.y = center.y - (zoomRect.size.height / 2.0)
        scrollView.zoom(to: zoomRect, animated: true)
    }

    @IBOutlet weak var lbl_zoom: UILabel!
    @IBAction func Zoom(_ sender: UISlider) {
        var center = CGPoint()
        let scrollViewSize = scrollView.bounds.size
        center.x = scrollViewSize.width / 2
        center.y = scrollViewSize.height / 2
        switch Int(sender.value){
          case 1 : zoomRectForScale(scale: scrollView.zoomScale * 0.5, center: center )
//          case 1 : zoomRectForScale(scale: scrollView.zoomScale * 1.5, center: center )
        case 3 : zoomRectForScale(scale: scrollView.zoomScale * 5.0, center: center )
        default:
            break
        }
  
    }
   

}
