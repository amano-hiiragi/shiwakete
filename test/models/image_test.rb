require 'test_helper'

class ImageTest < ActiveSupport::TestCase

  def setup
    @image =Image.new(url: 'https://pbs.twimg.com/media/D-KlnvHUcAA5ZQM.jpg')
  end

  test "should be valid" do
    assert @image.valid?
  end
end
