class TodayiceOgpGenerator < OgpImageGenerator
    private
    def base_image_path
        Rails.root.join("app/assets/images/ogpきょうのあいす用.png")
    end
end