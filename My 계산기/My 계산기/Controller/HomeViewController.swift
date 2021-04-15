import UIKit

class HomeViewController: UIViewController {

    @IBOutlet var calculatorButtonCollection: [UIButton]!
    @IBOutlet var calculatorLabelCollection: [UILabel]!
    
    var buttonIconArray: [UIImage] = [
        
        UIImage(named: "Normal white icon")!,
        UIImage(named: "unitconverter")!,
        UIImage(named: "discountcalculator")!,
        UIImage(named: "goldcalculator")!,
        UIImage(named: "exchangerate")!,
        UIImage(named: "gradecalculator")!
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My 계산기"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .bold)]

        configureButtonUI()
    }
    
    func configureButtonUI() {
        
        var index = 0
        
        for button in calculatorButtonCollection {
            
            button.layer.cornerRadius = button.frame.width / 2
            
            var buttonImage: UIImage = buttonIconArray[index]
            buttonImage = buttonImage.scalePreservingAspectRatio(targetSize: CGSize(width: 55, height: 55))
            button.setImage(buttonImage, for: .normal)
            index += 1
            
        }
        
        //0, 2,3
        var buttonImageForNormal: UIImage = buttonIconArray[0]
        var buttonImageForDiscount: UIImage = buttonIconArray[2]
        var buttonImageForGold: UIImage = buttonIconArray[3]

        buttonImageForNormal = buttonImageForNormal.scalePreservingAspectRatio(targetSize: CGSize(width: 60, height: 60))
        calculatorButtonCollection[0].setImage(buttonImageForNormal, for: .normal)
        
        buttonImageForDiscount = buttonImageForDiscount.scalePreservingAspectRatio(targetSize: CGSize(width: 57, height: 57))
        calculatorButtonCollection[2].setImage(buttonImageForDiscount, for: .normal)
        
        buttonImageForGold = buttonImageForGold.scalePreservingAspectRatio(targetSize: CGSize(width: 60, height: 60))
        calculatorButtonCollection[3].setImage(buttonImageForGold, for: .normal)
        
        
        
        calculatorButtonCollection[0].backgroundColor = Constants.Colors.normalCalculatorButtonColor
        calculatorButtonCollection[1].backgroundColor = Constants.Colors.unitConverterButtonColor
        calculatorButtonCollection[2].backgroundColor = Constants.Colors.discountCalculatorButtonColor
        calculatorButtonCollection[3].backgroundColor = Constants.Colors.goldCalculatorButtonColor
        calculatorButtonCollection[4].backgroundColor =
            Constants.Colors.exchangeRateButtonColor
        calculatorButtonCollection[5].backgroundColor = Constants.Colors.gradeCalculatorButtonColor
    }
}

extension UIImage {
    
    func scalePreservingAspectRatio(targetSize: CGSize) -> UIImage {
        // Determine the scale factor that preserves aspect ratio
        let widthRatio = targetSize.width / size.width
        let heightRatio = targetSize.height / size.height
        
        let scaleFactor = min(widthRatio, heightRatio)
        
        // Compute the new image size that preserves aspect ratio
        let scaledImageSize = CGSize(
            width: size.width * scaleFactor,
            height: size.height * scaleFactor
        )

        // Draw and return the resized UIImage
        let renderer = UIGraphicsImageRenderer(
            size: scaledImageSize
        )

        let scaledImage = renderer.image { _ in
            self.draw(in: CGRect(
                origin: .zero,
                size: scaledImageSize
            ))
        }
        
        return scaledImage
    }
}

