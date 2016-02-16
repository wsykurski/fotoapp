class User < ActiveRecord::Base
  has_attached_file :photo,
                    :path => ":rails_root/public/system/:attachment/:id/:basename_:style.:extension",
                    :url => "/system/:attachment/:id/:basename_:style.:extension",
                    :styles => {
                      :original => [:format => :jpg, :quality => 70],
                      :mysingle => ['300x400', :jpg, :quality => 70] 
                    },
                    :convert_options => {
                      :original => '-set colorspacesRGB -strip',
                      :mysingle => '-set colorspacesRGB -strip'
                    }
end
