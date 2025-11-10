class Admin::IceCreamsController < Admin::BaseController
    before_action :set_ice_cream, only: %i[show edit update destroy]

    def index
        @ice_creams = IceCream.all
    end

    def show
        @chart = @ice_cream.chart
        @user = @ice_cream.user
        original_name = @ice_cream.name
        search_word = fix_word(@ice_cream.name)

        if search_word.empty?
        @goods = []
        else
        begin
            @goods = RakutenWebService::Ichiba::Item.search(keyword: search_word)
        rescue => e
            Rails.logger.error "楽天APIエラー: #{e.message}"
            @goods = []
        end
        end
    end

    def new
        @ice_cream = IceCream.new
    end

    def edit
        @tag_names = @ice_cream.tags.pluck(:name).join(", ")
    end

    def create
        @ice_cream = IceCream.new(ice_cream_params)
        @ice_cream.admin = current_admin
        tag_list = params[:ice_cream][:tag_ids].split(",")

        if @ice_cream.save
        Chart.create!(
            ice_cream: @ice_cream,
            sweetness: @ice_cream.sweetness,
            freshness: @ice_cream.freshness,
            richness: @ice_cream.richness,
            calorie: @ice_cream.calorie,
            ingredient_richness: @ice_cream.ingredient_richness,
            chart_type: "official"
        )
        @ice_cream.save_tags(tag_list) if tag_list.present?
        redirect_to admin_ice_cream_path(@ice_cream), notice: "アイスクリームを作成しました"
        else
        render :new, status: :unprocessable_entity
        end
    end

    def update
        tag_names = params[:ice_cream][:tag_names]
            if @ice_cream.update(ice_cream_params)
                if tag_names.present?
                    tag_list = tag_names.split(",").map(&:strip)
                    tags = tag_list.map { |name| Tag.find_or_create_by(name: name) } # tag_namesを配列にし、タグを見つけるか作成
                    @ice_cream.tags = tags
                end
                redirect_to admin_ice_cream_path(@ice_cream), notice: "アイスクリームを更新しました"
            else
            puts @ice_cream.errors.full_messages
                render :edit, status: :unprocessable_entity
            end
    end

    def destroy
        @ice_cream.destroy
        redirect_to admin_ice_creams_path, notice: "アイスクリームを削除しました"
    end

    private

    def set_ice_cream
        @ice_cream = IceCream.find(params[:id])
    end

    def ice_cream_params
        params.require(:ice_cream).permit(:name, :image, :sweetness, :freshness, :richness, :calorie, :ingredient_richness, :user_id, :comment, :arrange, :calorie_value)
    end
    
    def fix_word(word)
        return "" if word.nil?
        word.to_s
        .strip
        .gsub(/[^\w\sぁ-んァ-ヶー一-龯]/, "")
        .gsub(/[！？＆＃＄％＾＊（）＋＝｜￥]/, "")
        .gsub(/\s+/, " ")
        .strip
    end
end
