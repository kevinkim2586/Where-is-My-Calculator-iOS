import UIKit


class HomeViewController: UIViewController {

    @IBOutlet var calculatorButtonCollection: [UIButton]!
    @IBOutlet var calculatorLabelCollection: [UILabel]!
    
    let buttonIconArray: [UIImage] = [
        
        UIImage(named: "Normal white icon")!,
        UIImage(named: "Unit white icon")!,
        UIImage(named: "Discount white icon")!,
        UIImage(named: "Gold white icon")!,
        UIImage(named: "Exchange white icon")!,
        UIImage(named: "Grade white icon")!
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "계산기"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .bold)]

        configureButtonUI()
    }
    
    func configureButtonUI() {
        
        var index = 0
        
        for button in calculatorButtonCollection {
            
            button.layer.cornerRadius = button.frame.width / 2
            
            var buttonImage: UIImage = buttonIconArray[index]
            buttonImage = buttonImage.scalePreservingAspectRatio(targetSize: CGSize(width: 60, height: 60))
            button.setImage(buttonImage, for: .normal)
            index += 1
            
        }
        
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

