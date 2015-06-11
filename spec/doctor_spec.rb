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
end
