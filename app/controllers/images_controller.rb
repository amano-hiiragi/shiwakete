class ImagesController < ApplicationController
  def top
  end

  def dltest
    require "open-uri"
    require "FileUtils"

    # url = image_params
    url = params[:image_url]

    p url

    # ready filepath
    fileName = File.basename(url)
    dirName = "/test/"
    filePath = dirName + fileName

    p fileName
    p dirName
    p filePath

    # create folder if not exist
    FileUtils.mkdir_p(dirName) unless FileTest.exist?(dirName)

    # write image adata
    open(filePath, 'wb') do |output|
      open(url) do |data|
        output.write(data.read)
      end
    end

    render 'top'
  end


  private

  def image_params
    params.require.permit(:image_url)
  end
end
