class XmlFilesController < ApplicationController
  before_action :authenticate_user!

  def new
    @xml_file = XmlFile.new
  end

  def create
    xml_file = XmlFile.new(xml_file_params)

    if xml_file.save
      redirect_to root_path, notice: I18n.t('messages.successfully')
    else
      flash.alert = I18n.t 'messages.failure'
    end
  end

  private

  def xml_file_params
    params.require(:xml_file).permit(xml_files: [])
  end
end
