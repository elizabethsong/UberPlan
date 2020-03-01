import UIKit
class RatingsController: UIStackView {
  var starsRating = 0
  var starsEmptyPicName = "star"
  var starsFilledPicName = "starfill"
  override func draw (_ rect: CGRect) {
    let myViews = self.subviews.filter{$0 is UIButton}
    var starTag = 1
    for theView in myViews {
      if let theButton = theView as? UIButton {
        theButton.setImage(UIImage(named: starsEmptyPicName), for: .normal)
        theButton.addTarget(self, action: #selector(self.pressede(sender:)), for: .touchUpInside)
        theButton.tag = starTag
        starTag = starTag + 1
      }
    }
     
  }
  @objc func pressede(sender: UIButton) {
    starsRating = sender.tag
    let myViews = self.subviews.filter{$0 is UIButton}
    for theView in myViews {
      if let theButton = theView as? UIButton {
        if theButton.tag > sender.tag { theButton.setImage(UIImage(named: starsEmptyPicName), for: .normal)
        } else {
        theButton.setImage(UIImage(named: starsFilledPicName), for: .normal)
        }
         
      }
    }
  }
}
