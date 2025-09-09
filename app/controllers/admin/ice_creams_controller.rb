class Admin::IceCreamsController < Admin::BaseController
    before_action :set_ice_cream, only: %i[show edit update destroy]

    def index
        @ice_creams = IceCream.all
    end

    def show
        @chart = @ice_cream.chart
    end

    def new
        @ice_cream = IceCream.new
    end

    def edit; end

    def create
        @ice_cream = IceCream.new(ice_cream_params)
        @ice_cream.admin = current_admin

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
        redirect_to admin_ice_cream_path(@ice_cream), notice: 'アイスクリームを作成しました'
        else
        render :new, status: :unprocessable_entity
        end
    end

    def update
        if @ice_cream.update(ice_cream_params)
        redirect_to admin_ice_cream_path(@ice_cream), notice: 'アイスクリームを更新しました'
        else
        puts @ice_cream.errors.full_messages
        render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        @ice_cream.destroy
        redirect_to admin_ice_creams_path, notice: 'アイスクリームを削除しました'
    end

    private

    def set_ice_cream
        @ice_cream = IceCream.find(params[:id])
    end

    def ice_cream_params
        params.require(:ice_cream).permit(:name, :image, :sweetness, :freshness, :richness, :calorie, :ingredient_richness, :user_id, :comment, :arrange, :calorie_value)
    end
end