class Photo < ActiveRecord::Base
  belongs_to :album

  #Paperclip
  has_attached_file :img,
    :styles => {
      :normal => "600x450>",
      :thumb=> "100x100#",
      :sized  => "150x150>" }
end
