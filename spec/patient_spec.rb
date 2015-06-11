require "spec_helper"

describe(Patient) do

  describe(".all") do
    it("starts off with no patients") do
      expect(Patient.all()).to(eq([]))
    end
  end

  describe("#save") do
    it("lets you save patients to DB") do
      patient = Patient.new({:id => nil, :name => "MaryAnn", :birthdate => '1980-06-06'})
      patient.save
      expect(Patient.all()).to(eq([patient]))
    end
  end

  describe("#==") do
    it("is the same patient if it has the same name") do
      patient1 = Patient.new({:id => nil, :name => "MaryAnn", :birthdate => '1980-06-06'})
      patient2 = Patient.new({:id => nil, :name => "MaryAnn", :birthdate => '1980-06-06'})
      expect(patient1).to(eq(patient2))
    end
  end

  describe("#id") do
    it("sets ID when put into DB") do
      patient = Patient.new({:id => nil, :name => "MaryAnn", :birthdate => '1980-06-06'})
      patient.save
      expect(patient.id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe("#name") do
    it("tells you the name of the patient") do
      patient = Patient.new({:id => nil, :name => "MaryAnn", :birthdate => '1980-06-06'})
      expect(patient.name()).to(eq("MaryAnn"))
    end
  end

  describe("#birthdate") do
    it("tells you the birthdate of the patient") do
      patient = Patient.new({:id => nil, :name => "MaryAnn", :birthdate => '1980-06-06'})
      expect(patient.birthdate()).to(eq('1980-06-06'))
    end
  end

  describe(".find") do
    it("returns a patient by his/her id.") do
      test_patient = Patient.new({:id => nil, :name => "MaryAnn", :birthdate => '1980-06-06'})
      test_patient.save()
      test_patient2 = Patient.new({:id => nil, :name => "Enrique", :birthdate => '1970-03-06'})
      test_patient2.save()
      expect(Patient.find(test_patient2.id())).to(eq(test_patient2))
    end
  end

  describe("#update") do
    it("lets you update patients in the database") do
      patient = Patient.new({:id => nil, :name => "Enrique", :birthdate => '1970-03-06'})
      patient.save()
      patient.update({:name => "Juan"})
      expect(patient.name()).to(eq("Juan"))
    end
  end

  describe("#delete") do
    it("lets you delete patient form the DB") do
      patient1 = Patient.new({:id => nil, :name => "Enrique", :birthdate => '1970-03-06'})
      patient1.save
      patient2 = Patient.new({:id => nil, :name => "Buffy", :birthdate => '1989-10-06'})
      patient2.save
      patient1.delete
      expect(Patient.all()).to(eq([patient2]))
    end
  end

end
