class AdvisementsController < ApplicationController

  def update
    @advisement = Advisement.find(params[:id])

    respond_to do |format|
      if @advisement.update(advisement_params)
        format.html { redirect_to @advisement.banner_person, notice: 'advisement was successfully updated.' }
        format.json { render :show, status: :ok, location: @advisement }
      else
        format.html { redirect_to @advisement.banner_person, error: 'advisement not successfully updated' }
        format.json { render json: @advisement.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def advisement_params
      params.require(:advisement).permit(:date, :value)
  end
end
