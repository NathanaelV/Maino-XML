class XmlFilesController < ApplicationController
  before_action :authenticate_user!

  def new
    @xml_file = XmlFile.new
  end

  def create; end
end
