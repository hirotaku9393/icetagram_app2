class OgpImageGenerator

    OUTPUT_DIR = Rails.root.join("public/ogp_images")
    
    def initialize(ice_cream:)
        @ice_cream = ice_cream   
    end

    def generate
        return nil unless @ice_cream

        begin
            make_directory

            base_image = MiniMagick::Image.open(base_image_path)
            base_image = add_ice_image(base_image)
            add_ice_name(base_image)

            

            filename = generate_filename
            output_path = OUTPUT_DIR.join(filename) 
            base_image.write(output_path)

            "/ogp_images/#{filename}"
        rescue => e
            Rails.logger.error "ogp作製 Error: #{e.message}"
            nil 
        end
    end

    private

    def base_image_path     
        raise NotImplementedError, "Subclasses must implement the base_image_path method"
    end

    def add_ice_name(image)
        font_path = Rails.root.join("app/assets/fonts/Kiwi_Maru/KiwiMaru-Regular.ttf")
        font_size = @ice_cream.name.length > 10 ? 48 : 64
        text = @ice_cream.name.to_s

        image.combine_options do |config|
            config.font font_path
            config.pointsize font_size
            config.gravity "Center"
            config.draw "text 0,-70 '#{text}'"
            config.fill "black"
        end
        image
    end

    def add_ice_image(image)
        begin
            file = URI.open(@ice_cream.image.url)
            ice_image = MiniMagick::Image.read(file)

            ice_image.combine_options do |config|
                config.resize "600x300"
                config.gravity "center"
                config.extent "600x300"
            end

            result = image.composite(ice_image) do |config|
                config.gravity "Center"
                config.geometry "+0+120"
                config.compose "Over"
            end
            result
        rescue => e
            Rails.logger.error "アイス画像の処理エラー: #{e.message}"

        end
    end

    def ice_image_url
        @ice_cream.image.url
    end

    def generate_filename
        timestamp = Time.current.to_i
        hash = Digest::MD5.hexdigest("#{@ice_cream.name}#{timestamp}")
        "ogp_ice_#{hash}.png"
    end   

    def make_directory
        FileUtils.mkdir_p(OUTPUT_DIR) unless Dir.exist?(OUTPUT_DIR)
    end
end