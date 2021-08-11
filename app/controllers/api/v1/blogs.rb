# frozen_string_literal: true
module Api
  module V1
  class Blogs < Grape::API
    include Default

    http_basic do |username, password|
      username == 'test' and password == 'hello'
      # put username and password in header
    end
    before do
      # @current_user = nil
      unless request.headers['X-Api-Secret-Key'] == 'api_secret_key'
        error!({code:1, message:'forbidden'}, 403)
      end
    end

    after do

    end

    before_validation do

    end

    after_validation do

    end

    # namespace , resource, group, segment are same as resources, it is just a namepace
    resources :blogs do

      route_param :id do
        resources :comments do
          get do
            build_response(data: "blog #{params[:id]} comments")
          end
        end
      end

      get '/' do
        {blogs:[]}
      end

      # /blogs/2
      params do
        use :id_validator
      end
      get ':id', requirements: { id: /\d+/ } do
        "id #{params[:id]}"
      end

      # /blogs/hot/pop/1231313
      get 'hot(/pop(/:id))' do
        "hot #{params[:id]}"
      end

      desc "create a blog"
      params do
        requires :title, type: String, desc: "blog params"
        requires :content, type: String, desc: "blog content", as: :body # give a new name to content
        optional :tags, type: Array, desc: "blog tags", allow_blank: false
        optional :state, type: Symbol, default: :pending, values: [:pending, :done]
        optional :meta_name, type: { value: String, message: "meta_name has to be string" },
                 regexp: {value: /^s\-/, message: "illigal"}
        optional :cover, type: File
        given :cover do
          requires :weight, type: Integer, values: { value: -> (v){v>=-1}, message: "weight has to be larger than -1"}
        end
        optional :comments, type: Array do
          requires :content, type: String, allow_blank: false
        end
        optional :category, type: Hash do
          requires :id, type: Integer
        end
      end
      post do
        "post #{params}"
      end

      put ":id" do
        "put #{params[:id]}"
      end

      delete ":id" do
        "delete #{params[:id]}"
      end

      get 'latest' do
        redirect '/api/v1/blogs/popular'
      end

      get 'popular' do
        # status 400
        # body
        # content_type
        # header 'AA', "value"
        'popular'
      end
    end
  end
  end
end


# curl --location --request POST 'http://localhost:3000/blogs' \
# --header 'Cookie: __profilin=p%3Dt' \
# --form 'title="a title"' \
# --form 'content="a content"' \
# --form 'state="pending"' \
# --form 'cover=@"/home/ryangao67/RubymineProjects/blog/babel.config.js"' \
# --form 'weight="4"' \
# --form 'comments[][content]="sss"' \
# --form 'category[id]="4"'