class EinvoicesController < ApplicationController
  before_action :authenticate_user!

  def new
    @einvoice = Einvoice.new
  end

  def create
    einvoices = Einvoice.new(einvoice_params)

    if einvoices.save
      redirect_to root_path, notice: I18n.t('messages.successfully')
    else
      flash.alert = I18n.t 'messages.failure'
    end
  end

  private

  def einvoice_params
    params.require(:einvoice).permit(:xml_file)
  end
end
