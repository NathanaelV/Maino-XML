class EinvoicesController < ApplicationController
  before_action :authenticate_user!

  def index
    @einvoices = Einvoice.all
  end

  def show
    @einvoice = Einvoice.find(params[:id])
  end

  def new
    @einvoice = Einvoice.new
  end

  def create
    einvoice = Einvoice.new(einvoice_params)

    if einvoice.save
      AssembleTheEinvoiceJob.perform_now(einvoice)
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
