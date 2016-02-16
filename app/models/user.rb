class User < ActiveRecord::Base
  has_attached_file :photo,
                    :path => ":rails_root/public/system/:attachment/:id/:basename_:style.:extension",
                    :url => "/system/:attachment/:id/:basename_:style.:extension",
                    :styles => {
                      :original => [:format => :jpg, :quality => 70],
                      :mysingle => ['200x300', :jpg, :quality => 70] 
                    },
                    :convert_options => {
                      :original => '-set colorspacesRGB -strip',
                      :mysingle => '-set colorspacesRGB -strip'
                    }
  validates_attachment :photo,
                       :presence => true,
                       :size => { :in => 0..10.megabytes },
                       :content_type => { :content_type => /^image\/(jpeg|png|gif|tiff)$/}
end
