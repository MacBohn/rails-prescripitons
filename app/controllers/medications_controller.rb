class MedicationsController < ApplicationController

  def show
    @patients = Patient.all
    @prescriptions = Prescription.all
    @medication = Medication.find(params[:id])
  end
end
