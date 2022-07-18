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
        self.petImagesRepository = petImagesRepository
        petName.text = self.viewModel.name
        petBreed.text = self.viewModel.breed
        petOrigin.text = self.viewModel.origin ?? "Not available"
        petLifeSpan.text = self.viewModel.lifeSpan
        setPetImage()
    }
    
    private func setPetImage() {
        petimageview.image = nil
        guard let petImagePath = viewModel.imageURL else { return }
        petImagesRepository?.fetchImage(with: petImagePath) { [weak self] result in
            guard let self = self else { return }
            guard self.viewModel.imageURL == petImagePath else { return }
            if case let .success(data) = result, let imageData = data {
                DispatchQueue.main.async { [weak self] in
                    self?.petimageview.image = UIImage(data: imageData)
                }
            }
        }
    }
}
