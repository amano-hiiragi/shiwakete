class ImagesController < ApplicationController
  def top
  end

  def serach
    redirect_to sorting_path(image: image_params)
  end

  def sorting
    @image_url = image_params[:url]
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

    image.save
    title.save
    character.save

    image.image_titles.build(title_id: title.id)
    image.image_characters.build(character_id: character.id)

    image.image_titles.create(title_id: title.id)
    image.image_characters.create(character_id: character.id)

    render 'sorting'
  end

  # def dltest
  #   require "open-uri"
  #   require "fileutils"

  #   # url = image_params
  #   url = params[:image_url]

  #   p url

  #   # ready filepath
  #   fileName = File.basename(url)
  #   dirName = "app/assets/images/"
  #   filePath = dirName + fileName

  #   p fileName
  #   p dirName
  #   p filePath

  #   # create folder if not exist
  #   FileUtils.mkdir_p(dirName) unless FileTest.exist?(dirName)

  #   # write image adata
  #   open(filePath, 'wb') do |output|
  #     open(url) do |data|
  #       output.write(data.read)
  #     end
  #   end

  #   render 'top'
  # end


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
