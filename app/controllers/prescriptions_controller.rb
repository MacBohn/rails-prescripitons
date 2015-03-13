class PrescriptionsController < ApplicationController




  def new
    @patient = Patient.find(params[:patient_id])
    @prescription = Prescription.new
  end

  def create
    @patient = Patient.find(params[:patient_id])
    @prescription = @patient.prescriptions.new(params.require(:prescription).permit(:medication_id, :dosage, :schedule, :starts_on, :ends_on))
    if @prescription.save
      redirect_to patient_path(@patient), notice: "Your prescription has been created"
    else
      render :new
    end
  end

end
