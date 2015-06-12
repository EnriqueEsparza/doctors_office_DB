require "sinatra"
require "sinatra/reloader"
also_reload("lib/**/*.rb")
require "./lib/doctor"
require "./lib/patient"
require "pg"

DB = PG.connect({:dbname => "doctors_office"})

get("/") do
  erb(:index)
end

get("/doctors") do
  @doctors = Doctor.all
  erb(:doctors)
end

post("/doctors") do
  name = params.fetch("name")
  specialty = params.fetch("specialty")
  doctor = Doctor.new({:id => nil, :name => name, :specialty => specialty, :patient_id => nil})
  doctor.save()
  @doctors = Doctor.all
  erb(:doctors)
end

get("/doctors/:id") do
  @doctors = Doctor.all
  @doctor = Doctor.find(params.fetch("id").to_i())
  @patients = Patient.all
  @patient = Patient.find(params.fetch("id").to_i())
  erb(:doctor)
end

patch("/doctors/:id") do
  doctor_id = params.fetch("id").to_i()
  @doctor = Doctor.find(doctor_id)
  patient_id = params.fetch("id")
  name = Doctor.name
  @doctor.update({:name => name, :patient_id => patient_id})
  @patients = Patient.all()
  erb(:doctor)
end

get("/patients") do
  erb(:patients)
end


post("/success") do
  name = params.fetch("name")
  birthdate = params.fetch("birthdate")
  patient = Patient.new({:id => nil, :name => name, :birthdate => birthdate})
  patient.save()
  @patients = Patient.all
  erb(:success)
end
