module Api
  module V1
    class ArticlesController < ApplicationController

      before_action :set_article, only: [:show, :update, :destroy]

      def index
        @articles = Article.order('created_at DESC')
        render json: {status: 'SUCCESS', message:'Loaded articles', data: @articles}, status: :ok
      end

      def show
        render json: {status: 'SUCCESS', message:'Loaded article', data: @article}, status: :ok
      end

      def create
        @article = Article.new(article_params)
        if @article.save
        render json: {status: 'SUCCESS', message:'Saved article', data: @article}, status: :ok
        else
          render json: {status: 'ERROR', message:'Article not saved', data:@article.errors}, status: :uproccessable_entity
        end
      end

      def update
        if @article.update_attributes(article_params)
        render json: {status: 'SUCCESS', message:'Article updated', data: @article}, status: :ok
        else
          render json: {status: 'ERROR', message:'Article not updated', data:@article.errors}, status: :uproccessable_entity
        end
      end

      def destroy
        @article.destroy
        render json: {status: 'SUCCESS', message:'Article deleted', data: @article}, status: :ok
      end

      private

      def article_params
        params.permit(:title, :body)
      end

      def set_article
        @article = Article.find(params[:id])
      end

    end
  end
end
