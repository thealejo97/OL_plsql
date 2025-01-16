--------- Creation Triggers ------------
BEGIN
   -- Trigger para Merchant
   EXECUTE IMMEDIATE '
      CREATE OR REPLACE TRIGGER trg_merchant_id
      BEFORE INSERT ON Merchant
      FOR EACH ROW
      BEGIN
         IF :NEW.id IS NULL THEN
            :NEW.id := merchant_seq.NEXTVAL;
         END IF;
      END;
   ';

   -- Trigger para Establishment
   EXECUTE IMMEDIATE '
      CREATE OR REPLACE TRIGGER trg_establishment_id
      BEFORE INSERT ON Establishment
      FOR EACH ROW
      BEGIN
         IF :NEW.id IS NULL THEN
            :NEW.id := establishment_seq.NEXTVAL;
         END IF;
      END;
   ';

   -- Trigger para Employee
   EXECUTE IMMEDIATE '
      CREATE OR REPLACE TRIGGER trg_employee_id
      BEFORE INSERT ON Employee
      FOR EACH ROW
      BEGIN
         IF :NEW.id IS NULL THEN
            :NEW.id := employee_seq.NEXTVAL;
         END IF;
      END;
   ';

   DBMS_OUTPUT.PUT_LINE('Triggers created successfully...');
EXCEPTION
   WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error creating triggers: ' || SQLERRM);
END;
--------- Audit Triggers ------------
BEGIN
   -- Trigger para auditoría en la tabla Merchant
   EXECUTE IMMEDIATE '
      CREATE OR REPLACE TRIGGER trg_merchant_audit
      BEFORE INSERT OR UPDATE ON Merchant
      FOR EACH ROW
      BEGIN
         IF INSERTING THEN
            :NEW.created_on := SYSDATE;
            :NEW.created_by := USER;
         END IF;

         :NEW.updated_on := SYSDATE;
         :NEW.updated_by := USER;
      END;
   ';

   -- Trigger para auditoría en la tabla Establishment
   EXECUTE IMMEDIATE '
      CREATE OR REPLACE TRIGGER trg_establishment_audit
      BEFORE INSERT OR UPDATE ON Establishment
      FOR EACH ROW
      BEGIN
         IF INSERTING THEN
            :NEW.created_on := SYSDATE;
            :NEW.created_by := USER;
         END IF;

         :NEW.updated_on := SYSDATE;
         :NEW.updated_by := USER;
      END;
   ';

   -- Trigger para auditoría en la tabla Employee
   EXECUTE IMMEDIATE '
      CREATE OR REPLACE TRIGGER trg_employee_audit
      BEFORE INSERT OR UPDATE ON Employee
      FOR EACH ROW
      BEGIN
         IF INSERTING THEN
            :NEW.created_on := SYSDATE;
            :NEW.created_by := USER;
         END IF;

         :NEW.updated_on := SYSDATE;
         :NEW.updated_by := USER;
      END;
   ';

   DBMS_OUTPUT.PUT_LINE('Audit Triggers created successfully.');
EXCEPTION
   WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error creating Audit Triggers: ' || SQLERRM);
END;
