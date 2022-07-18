import UIKit

class PetInfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var petName: UILabel!
    @IBOutlet weak var petBreed: UILabel!
    @IBOutlet weak var petOrigin: UILabel!
    @IBOutlet weak var petLifeSpan: UILabel!
    @IBOutlet weak var petimageview: UIImageView!
    
    private var viewModel: PetListItemViewModel!
    private var petImagesRepository: PetImageRepository?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func show(with viewModel: PetListItemViewModel, petImagesRepository: PetImageRepository?) {
        self.viewModel = viewModel
        petName.text = self.viewModel.name
        petBreed.text = self.viewModel.breed
        petOrigin.text = self.viewModel.origin
        petLifeSpan.text = self.viewModel.lifeSpan
        petimageview.image = UIImage()
    }
    
    private func setPetImage() {
        petimageview.image = nil
        guard let petImagePath = viewModel.imageURL else { return }
        petImagesRepository?.fetchImage(with: petImagePath) { [weak self] result in
            guard let self = self else { return }
            guard self.viewModel.imageURL == petImagePath else { return }
            if case let .success(data) = result, let imageData = data {
                self.petimageview.image = UIImage(data: imageData)
            }
        }
    }
}
