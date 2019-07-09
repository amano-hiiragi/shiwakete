class ImagesController < ApplicationController

  #alreadey = dbにsave済
  #

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
      redirect_to sorting_path(new_image_url: image_url)
    end
  end

  def sorting
    #画像urlでない場合警告文返したい
    #画像urlでない場合saveしないこと

    #既存image

    @user = current_user

    if params[:image_id]
      @alreadyImage = Image.find(params[:image_id])

      #tag全部
      imageTitle_ids = @alreadyImage.title_ids
      imageCharacter_ids= @alreadyImage.character_ids

      @titles = Title.where(id: imageTitle_ids)
      @characters = Character.where(id: imageCharacter_ids)
    end

    #新規url
    if params[:new_image_url]
      @newImage = Image.new(url: params[:new_image_url])
    end
  end

  def newimagerecord
    #完全新規img
    image = Image.new(image_params)
    title = Title.new(for_title_params)
    character = Character.new(for_character_params)

    image.save
    title.save
    character.save

    image.image_titles.create(title_id: title.id)
    image.image_characters.create(character_id: character.id)

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
   
       redirect_to images_success_path
  end

  def dlonlytest
    image = Image.find(image_params[:id])
    title = Title.find_by(title_of_work: for_title_params[:title_of_work])
    character = Character.find_by(character_name: for_character_params[:character_name])
    p title
    p character

        #DL未完

       # ready filepath
       require "open-uri"
       require "fileutils"
   
       fileName = File.basename(image.url)
       dirName = Rails.root.join("app/assets/images/add/test/hoge/#{title.title_of_work}/#{character.character_name}/")
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

       redirect_to images_success_path
  end

  def addrecord
    image = Image.find(image_params[:id])
    # title既存?
    if title = Title.find_by(title_of_work: for_title_params[:title_of_work])
      p title
      p "???"
    else
      p title
      p "funifuni"
      title = Title.new(title_of_work: for_title_params[:title_of_work])
      title.save
      image.image_titles.create(title_id: title.id)
    end

    if character = Character.find_by(character_name: for_character_params[:character_name])
      p character
      p "???"
    else
      p character
      p "funifuni"
      character = Character.new(character_name: for_character_params[:character_name])
      character.save
      image.image_characters.create(character_id: character.id)
    end

    redirect_to images_success_path
  end

  def ssend
    file_name="D-KlnvHUcAA5ZQM.jpg"
    filepath = Rails.root.join('app/assets/images/add/test/hoge/デレマス/小関麗奈/',file_name)
    stat = File::stat(filepath)
    send_file(filepath, :filename => file_name, :length => stat.size)
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
