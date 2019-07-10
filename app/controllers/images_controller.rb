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

  def record
    if image_params[:id]
      image = Image.find(image_params[:id])
    else
      #同時にnewimageとしてsortingに入ってた場合save済みになるかも
      if image = Image.find_by(url: image_params[:url])
        p "既存かsorting中に誰か完了した"
      else
        p "新規"
        image = Image.new(image_params)
        image.save
      end
    end

    #tagは新規?既存?
    if title = Title.find_by(title_of_work: for_title_params[:title_of_work])
      p "既存?"
      p "関連済みでダブりは?"
      if image.image_titles.find_by(title_id: title.id)
        p "ダブってるからcreate無し"
      else
        p "無いからcreate"
        image.image_titles.create(title_id: title.id)
      end
    else
      p "新規"
      title = Title.new(for_title_params)
      title.save
      image.image_titles.create(title_id: title.id)
    end

    if character = Character.find_by(character_name: for_character_params[:character_name])
      p "既存?"
      p "関連済みでダブりは?"
      if image.image_characters.find_by(character_id: character.id)
        p "ダブってるからcreate無し"
      else
        p "無いからcreate"
        image.image_characters.create(character_id: character.id)
      end
    else
      p "新規"
      character = Character.new(for_character_params)
      character.save
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
   
       redirect_to test_path(image_url: image.url,
                                        title_of_work: title.title_of_work,
                                        character_name: character.character_name)
  end

  def success
    @image_url = params[:image_url]
    @title_of_work =  params[:title_of_work]
    @character_name = params[:character_name]
  end

  def ssend
    require "open-uri"

    image_url = params[:image_url]
    file_name = "#{params[:title_of_work]}-#{params[:character_name]}"

    send_file(open(image_url), filename: file_name)
  end

  private

  def image_params
    params.require(:image).permit(:id, :url)
  end
  def for_title_params
    params.require(:title).permit(:title_of_work)
  end
  def for_character_params
    params.require(:character).permit(:character_name)
  end
end
