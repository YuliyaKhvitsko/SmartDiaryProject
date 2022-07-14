//
//  NewsViewCell.swift
//  NewProjectYulya
//
//  Created by Yuliya Khvitsko on 11.07.22.
//

import UIKit

class NewsViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var agoLabel: UILabel!
    @IBOutlet weak var badgeLabel: UILabel!
    
//    var articles: [Article] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(articles: Article) {
        titleLabel.numberOfLines = 3
        titleLabel.font = .boldSystemFont(ofSize: 15)

        badgeLabel.backgroundColor = .systemGray
        badgeLabel.textColor = .white
        badgeLabel.font = .boldSystemFont(ofSize: 14)
        badgeLabel.textAlignment = .center

        agoLabel.textColor = .secondaryLabel
        agoLabel.font = .systemFont(ofSize: 15)
        

       titleLabel.text = articles.title
       agoLabel.text = articles.agoSource
    
        guard let image = articles.urlToImage else { return }
        
        let url = NSURL(string: image)
       
        articleImageView?.sd_setImage(with: url as URL?, placeholderImage: nil)
    
}
}
private extension Article {

    var agoSource: String {
        var bottom = ago ?? ""
        if let source = source?.name {
            bottom += " | " + source
        }
        return bottom
    }

}
