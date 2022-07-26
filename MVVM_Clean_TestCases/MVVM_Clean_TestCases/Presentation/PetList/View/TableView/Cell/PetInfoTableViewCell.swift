import UIKit

class PetInfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var petName: UILabel!
    @IBOutlet weak var petBreed: UILabel!
    @IBOutlet weak var petOrigin: UILabel!
    @IBOutlet weak var petLifeSpan: UILabel!
    
    private var viewModel: PetListItemViewModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func show(with viewModel: PetListItemViewModel) {
        self.viewModel = viewModel
        petName.text = self.viewModel.name
        petBreed.text = (self.viewModel.breed ?? "").isEmpty ? "----" : self.viewModel.breed
        petOrigin.text = (self.viewModel.origin ?? "").isEmpty ? "----" : self.viewModel.origin
        petLifeSpan.text = self.viewModel.lifeSpan
    }
}
