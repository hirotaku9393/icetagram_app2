class AjigrafOgpGenerator < OgpImageGenerator
    private
    def base_image_path
        Rails.root.join("app/assets/images/ogpあじぐらふ用.png")
    end
end