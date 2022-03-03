
CREATE TABLE patients (
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY NOT NULL,
  name VARCHAR(50) NOT NULL,
  date_of_birth DATE NOT NULL
);

CREATE TABLE medical_histories (
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY NOT NULL,
  admitted_at TIMESTAMP NOT NULL,
  patient_id INT NOT NULL,
  status VARCHAR(50) NOT NULL
);

CREATE TABLE invoices (
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY NOT NULL,
  total_amount DECIMAL NOT NULL,
  generated_at TIMESTAMP NOT NULL,
  payed_at TIMESTAMP NOT NULL,
  medical_history_id INT NOT NULL
);

CREATE TABLE invoice_items (
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY NOT NULL,
  unit_price DECIMAL NOT NULL,
  quantity INT NOT NULL,
  total_price DECIMAL NOT NULL,
  invoice_id INT NOT NULL,
  treatment_id INT NOT NULL
);

CREATE TABLE treatments (
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY NOT NULL,
  type VARCHAR(50) NOT NULL,
  name VARCHAR(50) NOT NULL
);

/* Create foreign keys */
ALTER TABLE medical_histories
  ADD CONSTRAINT patient_id_fk
  FOREIGN KEY (patient_id)
  REFERENCES patients(id);

ALTER TABLE invoices
  ADD CONSTRAINT invoices_medical_history_id_fk
  FOREIGN KEY (medical_history_id)
  REFERENCES medical_histories(id);

ALTER TABLE invoice_items
  ADD CONSTRAINT invoices_fk
  FOREIGN KEY (invoice_id)
  REFERENCES invoices(id);

ALTER TABLE invoice_items
  ADD CONSTRAINT treatments_fk
  FOREIGN KEY (treatment_id)
  REFERENCES treatments(id);

/* Many to Many */
CREATE TABLE medical_treatment (
  medical_history_id INT NOT NULL,
  treatment_id INT NOT NULL,
  PRIMARY KEY (medical_history_id, treatment_id),
  CONSTRAINT medical_history_fk
    FOREIGN KEY (medical_history_id)
    REFERENCES medical_histories(id),
  CONSTRAINT treatment_fk
    FOREIGN KEY(treatment_id)
    REFERENCES treatments(id)
);

/* Create index to foreign keys */
CREATE INDEX patient_id ON medical_histories (patient_id ASC);
CREATE INDEX medical_history_id ON invoices (medical_history_id ASC);
CREATE INDEX invoice_id ON invoice_items (invoice_id ASC);
CREATE INDEX treatment_id ON invoice_items (treatment_id ASC);