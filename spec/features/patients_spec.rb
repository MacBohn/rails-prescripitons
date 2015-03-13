require 'rails_helper'
require 'capybara/rails'

feature "Patients" do

  scenario "User sees all patients" do
    user = create_user
    patient = create_patient
    login(user)

    expect(page).to have_content(patient.first_name)
    expect(page).to have_content(patient.last_name)
  end

  scenario "User can click on patients name" do
    user = create_user
    patient = create_patient
    login(user)

    click_on "Some Patient"

    within ".page-header" do
      expect(page).to have_content("Some Patient")
    end

    within ".table" do

    end
  end

  scenario "User can click on add prescriptions" do
    user = create_user
    patient = create_patient
    login(user)
    medication = create_medication

    click_on "Some Patient"

    click_on "Add Prescription"

    select 'Advil', from: 'prescription_medication_id'
    fill_in 'Dosage', with: "30 pills"
    fill_in 'Schedule', with: "2 times a day"
    fill_in 'Starts on', with: "1/1/2016"
    fill_in 'Ends on', with: "2/1/2016"

    click_on "Create Prescription"

    expect(page).to have_content("Your prescription has been created")

    within ".table" do
      expect(page).to have_content("Advil")
      expect(page).to have_content("2 times a day")
      expect(page).to have_content("2016-01-01")
      expect(page).to have_content("2016-01-02")
    end
  end

  scenario "All fields for a prescription are required" do
    user = create_user
    patient = create_patient
    login(user)
    medication = create_medication

    click_on "Some Patient"

    click_on "Add Prescription"

    fill_in 'Dosage', with: ""
    fill_in 'Schedule', with: ""
    fill_in 'Starts on', with: ""
    fill_in 'Ends on', with: ""

    click_on "Create Prescription"

    expect(page).to have_content("Medication can't be blank")
    expect(page).to have_content("Dosage can't be blank")
    expect(page).to have_content("Schedule can't be blank")
    expect(page).to have_content("Starts on can't be blank")
    expect(page).to have_content("Ends on can't be blank")
  end

  scenario "Users can see prescriptions from the medications show page" do
    user = create_user
    patient = create_patient
    login(user)
    medication = create_medication

    click_on "Some Patient"

    click_on "Add Prescription"

    select 'Advil', from: 'prescription_medication_id'
    fill_in 'Dosage', with: "30 pills"
    fill_in 'Schedule', with: "2 times a day"
    fill_in 'Starts on', with: "1/1/2016"
    fill_in 'Ends on', with: "2/1/2016"

    click_on "Create Prescription"

    click_on "Prescriptions"

    click_on "Advil"

    expect(page).to have_content("Advil")
    expect(page).to have_content("Some Patient")


  end

  scenario "Dosage field must start with a number" do

    user = create_user
    patient = create_patient
    login(user)
    medication = create_medication

    click_on "Some Patient"

    click_on "Add Prescription"

    select 'Advil', from: 'prescription_medication_id'
    fill_in 'Dosage', with: "pills"
    fill_in 'Schedule', with: "2 times a day"
    fill_in 'Starts on', with: "1/1/2016"
    fill_in 'Ends on', with: "2/1/2016"

    click_on "Create Prescription"

    expect(page).to have_content("Dosage is invalid")
  end

  scenario "End date cannot be before start date on prescriptions" do

    user = create_user
    patient = create_patient
    login(user)
    medication = create_medication

    click_on "Some Patient"

    click_on "Add Prescription"

    select 'Advil', from: 'prescription_medication_id'
    fill_in 'Dosage', with: "pills"
    fill_in 'Schedule', with: "2 times a day"
    fill_in 'Starts on', with: "1/1/2020"
    fill_in 'Ends on', with: "2/1/2016"

    click_on "Create Prescription"

    expect(page).to have_content("Starts on Must be before end date")


  end

end
