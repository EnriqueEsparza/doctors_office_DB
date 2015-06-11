class Patient
  attr_reader(:id, :name, :birthdate)

  define_method(:initialize) do |attributes|
    @id = attributes.fetch(:id).to_i
    @name = attributes.fetch(:name)
    @birthdate = attributes.fetch(:birthdate)
  end

  define_singleton_method(:all) do
    returned_patients = DB.exec("SELECT * FROM patients;")
    patients = []
    returned_patients.each() do |patient|
      name = patient.fetch("name")
      id = patient.fetch("id")
      birthdate = patient.fetch("birthdate")
      patients.push(Patient.new({:id => id, :name => name, :birthdate => birthdate}))
    end
    patients
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO patients (name, birthdate) VALUES ('#{@name}', '#{@birthdate}') RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  define_method(:==) do |another_patient|
    self.name().==(another_patient.name()).&(self.id().==(another_patient.id()))
  end

  define_singleton_method(:find) do |id|
    found_patient = nil
    Patient.all().each() do |patient|
      if patient.id().==(id)
        found_patient = patient
      end
    end
    found_patient
  end

  define_method(:update) do |attributes|
    @name = attributes.fetch(:name)
    @id = self.id()
    DB.exec("UPDATE patients SET name = '#{@name}' WHERE id = #{@id};")
  end

  define_method(:delete) do
    DB.exec("DELETE FROM doctors WHERE id = #{self.id()};")
    DB.exec("DELETE FROM patients WHERE id = #{self.id()};")
  end


end
