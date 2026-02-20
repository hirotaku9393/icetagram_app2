class AjigrafCreator
    require "mini_magick"
    BASE_IMAGE_PATH = "app/assets/images/ogpあじぐらふ用.png"
    GRAVITY = "center"
    TEXT_POSITION = "0,0"
    FONT = "app/assets/fonts/Kiwi_Maru/KiwiMaru-Regular.ttf"
    FONT_SIZE = 80
    INDENTION_COUNT = 10
    ROW_LIMIT = 8

    def self.build(text)
        text = prepare_text(text) + "!"
        # gem 'mini_magick'を使用して合成元画像を開く
        image = MiniMagick::Image.open(BASE_IMAGE_PATH)
        image.combine_options do |config|
        config.font FONT
        config.fill "black"
        config.gravity GRAVITY
        config.pointsize FONT_SIZE
        safe_text = text.gsub("'", "") # シングルクォートをエスケープ
        config.draw "text #{TEXT_POSITION} '#{safe_text}'"
        end
    end

    private
    def self.prepare_text(text)
        text.to_s.scan(/.{1,#{INDENTION_COUNT}}/)[0...ROW_LIMIT].join("\n")
    end
end
