import UIKit

class ViewController: UIViewController {
    var cells: [CustomCell] = []
    var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor(named: "PurpleNS")?.cgColor as Any, UIColor.black.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.locations = [0, 0.7]
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        scrollView = UIScrollView()
        view.addSubview(scrollView)
        
        let titleLabel = UILabel()
        titleLabel.text = "Клеточное наполнение"
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        scrollView.addSubview(titleLabel)
        
        let createButton = UIButton(type: .system)
        createButton.setTitle("Сотворить", for: .normal)
        createButton.tintColor = .white
        createButton.backgroundColor = UIColor(named: "PurpleNS")
        createButton.layer.cornerRadius = 5
        createButton.addTarget(self, action: #selector(createCell), for: .touchUpInside)
        view.addSubview(createButton)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        createButton.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: createButton.topAnchor, constant: -10),
            
            titleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            
            createButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 20),
            createButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            createButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            createButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        var contentRect = CGRect.zero
        for view in scrollView.subviews {
            contentRect = contentRect.union(view.frame)
        }
        scrollView.contentSize = CGSize(width: scrollView.bounds.width, height: contentRect.height)
    }
    
    
    
    @objc func createCell() {
        
        let newCell = CustomCell()
        newCell.stateText = Bool.random() ? "Живая" : "Мёртвая"
        scrollView.addSubview(newCell)
        cells.append(newCell)
        newCell.layer.cornerRadius = 5
        newCell.translatesAutoresizingMaskIntoConstraints = false
        let topOffset = CGFloat(60 + (cells.count - 1) * 80 + (cells.count - 1) * 10)
        
        NSLayoutConstraint.activate([
            newCell.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: topOffset),
            newCell.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            newCell.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40),
            newCell.bottomAnchor.constraint(lessThanOrEqualTo: scrollView.bottomAnchor, constant: -10),
            newCell.heightAnchor.constraint(equalToConstant: 80),
        ])
        
        scrollView.contentSize = CGSize(width: scrollView.bounds.width, height: topOffset + 80)
        
        if scrollView.contentSize.height > scrollView.bounds.height {
            let bottomOffset = CGPoint(x: 0, y: scrollView.contentSize.height - scrollView.bounds.size.height)
            scrollView.setContentOffset(bottomOffset, animated: true)
        }
        
        if cells.count >= 3 &&
            cells[cells.count - 3...cells.count - 1].allSatisfy({ $0.stateText == "Мёртвая" }) {
            if let lastLifeCellIndex = cells.lastIndex(where: { $0.stateText == "Жизнь" }) {
                cells[lastLifeCellIndex].removeFromSuperview()
                cells.remove(at: lastLifeCellIndex)
            }
        }
        
        if cells.count >= 3 &&
            cells[cells.count - 3...cells.count - 1].allSatisfy({ $0.stateText == "Живая" }) {
            let lifeCell = CustomCell()
            lifeCell.stateText = "Жизнь"
            lifeCell.additionalLabel.text = "Ку-Ку!"
            lifeCell.imageView.image = UIImage(named: "chiken")
            scrollView.addSubview(lifeCell)
            cells.append(lifeCell)
            lifeCell.layer.cornerRadius = 5
            lifeCell.translatesAutoresizingMaskIntoConstraints = false
            let lifeTopOffset = CGFloat(70 + (cells.count - 1) * 80 + (cells.count - 2) * 10)
            
            NSLayoutConstraint.activate([
                lifeCell.topAnchor.constraint(equalTo: newCell.bottomAnchor, constant: 10),
                lifeCell.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
                lifeCell.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40),
                lifeCell.heightAnchor.constraint(equalToConstant: 80),
                lifeCell.bottomAnchor.constraint(lessThanOrEqualTo: scrollView.bottomAnchor, constant: -10)
            ])
            
            scrollView.contentSize = CGSize(width: scrollView.bounds.width, height: lifeTopOffset + 80)
        }
    }
}
