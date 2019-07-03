class ImagesController < ApplicationController
  def top
  end

  def serach
    image_url = image_params[:url]
    #imageが新規か既存か分ける
    #@image_urlはDBに存在?
    alreadyImage = Image.find_by(url: image_url)
    if alreadyImage
      p "する   = 既存image"
      redirect_to sorting_path(image_id: alreadyImage)
    else
      p "しない = 新規image"
      redirect_to sorting_path(newImage_url: image_url)
    end
  end

  def sorting
    #画像urlでない場合警告文返したい
    #画像urlでない場合saveしないこと

    #既存image
    if params[:image_id]
      @alreadyImage = Image.find(params[:image_id])

      #tag全部
      imageTitle_ids = @alreadyImage.title_ids
      imageCharacter_ids= @alreadyImage.character_ids

      @titles = Title.where(id: imageTitle_ids)
      @characters = Character.where(id: imageCharacter_ids)
    end

    #新規url
    if params[:newImage_url]
      @newImage = Image.new(url: params[:newImage_url])
    end
  end




  def record
    #既存imgか新規imgか

      #既存image
      if image_params[:id]
        image = Image.find(image_params[:id])
        p image

        #tag既存か新規

          #all新規
          title = Title.new(for_title_params)
          p title
          character = Character.new(for_character_params)
          p character


          p "save"
          title.save
          character.save

          p "create"
          image.image_titles.create(title_id: title.id)
          image.image_characters.create(character_id: character.id)

      end

      #新規img
      if image_params[:url]
        image = Image.new(url: image_params[:url])
        title = Title.new(for_title_params)
        character = Character.new(for_character_params)

        image.save
        title.save
        character.save

        image.image_titles.create(title_id: title.id)
        image.image_characters.create(character_id: character.id)
      end

    #DL未完

       # ready filepath
       require "open-uri"
       require "fileutils"
   
       fileName = File.basename(image.url)
       dirName = Rails.root.join("app/assets/images/test/hoge/#{title.title_of_work}/#{character.character_name}/")
       filePath = dirName + fileName
   
       p fileName
       p dirName
       p filePath
   
       #dir無かったら作成する
       FileUtils.mkdir_p(dirName) unless FileTest.exist?(dirName)
   
       #ひとまずrails内には保存出来た
       open(filePath, 'wb') do |output|
         open(image.url) do |data|
           output.write(data.read)
         end
       end
   
       send_file(filePath, filename: "test")
       #読まない
       # send_file(image.url)

    render 'sorting'
  end






  def test
    p "---"
    p params
    p params[:image]
    p params[:image][:url]
    p params[:image][:title_of_work]
    p params[:image][:character_name]
    p "---"

    p "___________"
    p image_params
    p for_title_params
    p for_character_params
    p "___________"

    # ready filepath
    require "open-uri"
    require "fileutils"

    fileName = File.basename(url)
    dirName = Rails.root.join("app/assets/images/")
    filePath = dirName + fileName

    p fileName
    p dirName
    p filePath

    #dir無かったら作成する
    FileUtils.mkdir_p(dirName) unless FileTest.exist?(dirName)

    #ひとまずrails内には保存出来た
    open(filePath, 'wb') do |output|
      open(url) do |data|
        output.write(data.read)
      end
    end

    send_file(filePath, filename: "test")
    #読まない
    # send_file(image.url)



    render 'sorting'
  end

  private

  def image_params
    params.require(:image).permit(:id, :url)
  end

  def for_title_params
    params.require(:image).permit(:title_of_work)
  end

  def for_character_params
    params.require(:image).permit(:character_name)
  end
end
