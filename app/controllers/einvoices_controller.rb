class EinvoicesController < ApplicationController
  before_action :authenticate_user!

  def new
    @einvoice = Einvoice.new
  end

  def create
    einvoice = Einvoice.new(einvoice_params)

    if einvoice.save
      AssembleTheEinvoiceJob.perform_later(einvoice)
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
