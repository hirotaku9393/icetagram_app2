class ReviewsController < ApplicationController
    before_action :set_ice_cream

    def create
        @review = @ice_cream.reviews.new(review_params)
        @review.user = current_user

        if @review.save
        redirect_to @ice_cream, notice: "感想を投稿しました！"
        else
        redirect_to @ice_cream, alert: "感想を投稿できませんでした…"
        end
    end

    def destroy
        @review = @ice_cream.reviews.find(params[:id])
        @review.destroy
        redirect_to @ice_cream, notice: "感想を削除しました"
    end

    private

    def set_ice_cream
        @ice_cream = IceCream.find(params[:ice_cream_id])
    end

    def review_params
        params.require(:review).permit(:content)
    end
end
