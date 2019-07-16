module ImagesHelper


    def get_image_urls(url)
        require 'open-uri' 
        require 'resolv-replace'
        require 'timeout'

        uri = URI(url)
        tmp_images = uri.read.scan(/img.+src=[\"|\']?([\-_\.\!\~\*\'\(\)a-zA-Z0-9\;\/\?\:@&=\$\,\%\#]+\.(jpg|jpeg|png|gif|bmp))/i)
        images = []
        tmp_images.each { |img| images << URI.join(url, img[0]) }
        images.uniq
    end
end
