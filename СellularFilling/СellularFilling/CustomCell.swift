import UIKit

class CustomCell: UIView {
    var stateLabel: UILabel = UILabel()
    var additionalLabel: UILabel = UILabel()
    var imageView: UIImageView = UIImageView()
    
    var stateText: String = "" {
        didSet {
            stateLabel.text = stateText
            stateLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
            additionalLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
            if stateText == "Живая" {
                imageView.image = UIImage(named: "featherIcon")
                additionalLabel.text = "и шевелится!"
            } else {
                imageView.image = UIImage(named: "skullIcon")
                additionalLabel.text = "или прикидывается"
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        backgroundColor = .white
        
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        
        stateLabel.textAlignment = .center
        stateLabel.textColor = .black
        stateLabel.font = UIFont.systemFont(ofSize: 16)
        stateLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stateLabel)
        
        additionalLabel.textAlignment = .center
        additionalLabel.textColor = .black
        additionalLabel.font = UIFont.systemFont(ofSize: 12)
        additionalLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(additionalLabel)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            imageView.widthAnchor.constraint(equalToConstant: 45),
            imageView.heightAnchor.constraint(equalToConstant: 45),
            
            stateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            stateLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
            
            additionalLabel.topAnchor.constraint(equalTo: stateLabel.bottomAnchor, constant: 5),
            additionalLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
        ])
    }
}
