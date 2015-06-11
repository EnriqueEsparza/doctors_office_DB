class Doctor
  attr_reader(:id, :name, :specialty, :patient_id)

  define_method(:initialize) do |attributes|
    @id = attributes.fetch(:id).to_i
    @name = attributes.fetch(:name)
    @specialty = attributes.fetch(:specialty)
    @patient_id = attributes.fetch(:patient_id).to_i
  end

  define_singleton_method(:all) do
    returned_doctors = DB.exec("SELECT * FROM doctors;")
    doctors = []
    returned_doctors.each() do |doctor|
      name = doctor.fetch("name")
      id = doctor.fetch("id")
      specialty = doctor.fetch("specialty")
      patient_id = doctor.fetch("patient_id")
      doctors.push(Doctor.new({:id => id, :name => name, :specialty => specialty, :patient_id => patient_id}))
    end
    doctors
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO doctors (name, specialty, patient_id) VALUES ('#{@name}', '#{@specialty}', '#{@patient_id}') RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  define_method(:==) do |another_doctor|
    self.name().==(another_doctor.name()).&(self.id().==(another_doctor.id()))
  end

end
