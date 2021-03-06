class User < ActiveRecord::Base
  has_attached_file :photo,
                    :path => ":rails_root/public/system/:attachment/:id/:basename_:style.:extension",
                    :url => "/system/:attachment/:id/:basename_:style.:extension",
                    :styles => {
                      :original => [:format => :jpg, :quality => 100],
                      :mysingle => ['492x610', :jpg, :quality => 100],
                      #:crop => ['492x610#', :jpg, :quality =>100]
                    },
                    :convert_options => {
                      :original => '-set colorspacesRGB -strip',
                      :mysingle => '-set colorspacesRGB -strip -sharpen 0x0.5 ',
                      #:crop => '-set colorspacesRGB -strip -sharpen 0x0.5'
                    },
                    :processors => [:cropper]
  validates_attachment :photo,
                       :presence => true,
                       :size => { :in => 0..10.megabytes },
                       :content_type => { :content_type => /^image\/(jpeg|pjpeg|png|gif|tiff|x-png)$/}
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h

  def cropping?
    !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  end

  def reprocess_avatar
    photo.reprocess!
  end

  def avatar_geometry(style = :original)
    @geometry ||= {}
    @geometry[style] ||= Paperclip::Geometry.from_file(photo.path(style))
  end

end
