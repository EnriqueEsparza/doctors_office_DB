require "spec_helper"

describe(Doctor) do

  describe(".all") do
    it("starts off with no doctors") do
      expect(Doctor.all()).to(eq([]))
    end
  end

  describe("#save") do
    it("lets you save doctors to DB") do
      doctor = Doctor.new({:id => nil, :name => "Dr.Jones", :specialty => "Pediatrics", :patient_id => 5})
      doctor.save
      expect(Doctor.all()).to(eq([doctor]))
    end
  end

  describe("#==") do
    it("is the same doctor if it has the same name") do
      dr1 = Doctor.new({:id => nil, :name => "Dr.Jones", :specialty => "Pediatrics", :patient_id => 5})
      dr2 = Doctor.new({:id => nil, :name => "Dr.Jones", :specialty => "Pediatrics", :patient_id => 5})
      expect(dr1).to(eq(dr2))
    end
  end

  describe("#id") do
    it("sets ID when put into DB") do
      doctor = Doctor.new({:id => nil, :name => "Dr.Jones", :specialty => "Pediatrics", :patient_id => 5})
      doctor.save
      expect(doctor.id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe("#name") do
    it("tells you the name of the doctor") do
      doctor = Doctor.new({:id => nil, :name => "Dr.Jones", :specialty => "Pediatrics", :patient_id => 5})
      expect(doctor.name()).to(eq("Dr.Jones"))
    end
  end

  describe("#specialty") do
    it("tells you the specialty of the doctor") do
      doctor = Doctor.new({:id => nil, :name => "Dr.Jones", :specialty => "Pediatrics", :patient_id => 5})
      expect(doctor.specialty()).to(eq("Pediatrics"))
    end
  end

  describe("#patient_id") do
    it("tells you the id of the doctor's patient") do
      doctor = Doctor.new({:id => nil, :name => "Dr.Jones", :specialty => "Pediatrics", :patient_id => 5})
      expect(doctor.patient_id()).to(eq(5))
    end
  end

  describe(".find") do
    it("returns a doctor by his/her id.") do
      test_doctor = Doctor.new({:id => nil, :name => "Dr.Jones", :specialty => "Pediatrics", :patient_id => 5})
      test_doctor.save()
      test_doctor2 = Doctor.new({:id => nil, :name => "Dr.Paul", :specialty => "Cardiologist", :patient_id => 3})
      test_doctor2.save()
      expect(Doctor.find(test_doctor2.id())).to(eq(test_doctor2))
    end
  end

  describe("#update") do
    it("lets you update doctors in the database") do
      doctor = Doctor.new({:id => nil, :name => "Dr.Jones", :specialty => "Pediatrics", :patient_id => 5})
      doctor.save()
      doctor.update({:name => "Dr.Paul"})
      expect(doctor.name()).to(eq("Dr.Paul"))
    end
  end

  describe("#delete") do
    it("lets you delete doctor form the DB") do
       doctor1 = Doctor.new({:id => nil, :name => "Dr.Jones", :specialty => "Pediatrics", :patient_id => 5})
       doctor1.save
       doctor2 = Doctor.new({:id => nil, :name => "Dr.Phil", :specialty => "LoudMouth", :patient_id => 3})
       doctor2.save
       doctor1.delete
       expect(Doctor.all()).to(eq([doctor2]))
     end
   end
end
