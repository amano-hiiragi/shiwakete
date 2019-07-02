class ImagesController < ApplicationController
  def top
  end

  def serach
    redirect_to sorting_path(image: image_params)
  end

  def sorting
    #formへの入力なければ@image_urlはnilのまま
    #画像urlでない場合警告文返したい
    #画像urlでない場合saveしないこと
    unless image_params[:url].blank?
      @image_url = image_params[:url]
    end

    alreadyImage = Image.find_by(url: @image_url)

    p alreadyImage
    p alreadyImage.image_titles
    p alreadyImage.image_characters

    test = alreadyImage.image_titles.first
    test2 = alreadyImage.image_characters.first

    @image_title = Title.find_by(id: test.title_id).title_of_work
    @image_character =  Character.find_by(id: test2.character_id).character_name
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

    image = Image.new(image_params)
    title = Title.new(for_title_params)
    character = Character.new(for_character_params)
    
    p "---"
    p image
    p title
    p character
    p "test" * 10

    # ready filepath
    require "open-uri"
    require "fileutils"

    fileName = File.basename(image.url)
    dirName = Rails.root.join("app/assets/images/")
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

    #save

    # image.save
    # title.save
    # character.save

    # image.image_titles.create(title_id: title.id)
    # image.image_characters.create(character_id: character.id)

    render 'sorting'
  end

  def dltest2
    send_file '/path/test_pdf.pdf', :filename => 'test.pdf'
  end

  private

  def image_params
    params.require(:image).permit(:url)
  end

  def for_title_params
    params.require(:image).permit(:title_of_work)
  end

  def for_character_params
    params.require(:image).permit(:character_name)
  end
end
