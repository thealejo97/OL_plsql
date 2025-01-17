CREATE OR REPLACE PACKAGE BODY C##OL_SCHEMA.PKG_MERCHANT IS
   FUNCTION get_merchant_by_id(p_id IN NUMBER) RETURN SYS_REFCURSOR IS
      l_cursor SYS_REFCURSOR;
   BEGIN
      OPEN l_cursor FOR
         SELECT 
            m.business_name,
            m.department,
            m.city,
            m.phone,
            m.email,
            m.created_on,
            m.status,
            NVL(LISTAGG(e.name, ', ') WITHIN GROUP (ORDER BY e.name), 'No Establishments') AS establishment_names,
            NVL(SUM(e.revenue), 0) AS total_revenue,
            NVL(SUM(e.employee_count), 0) AS total_employees            
         FROM Merchant m
         LEFT JOIN Establishment e ON e.merchant_id = m.id
         WHERE m.id = p_id
         GROUP BY 
            m.business_name, m.department, m.city, 
            m.phone, m.email, m.created_on, m.status;

      RETURN l_cursor;
   END get_merchant_by_id;


   FUNCTION get_merchants(p_name_filter IN VARCHAR2 DEFAULT NULL, 
                          p_city_filter IN VARCHAR2 DEFAULT NULL, 
                          p_status_filter IN VARCHAR2 DEFAULT NULL,
                          p_offset IN NUMBER DEFAULT 0, 
                          p_limit IN NUMBER DEFAULT 10) RETURN SYS_REFCURSOR IS
      l_cursor SYS_REFCURSOR;
   BEGIN
      OPEN l_cursor FOR
         SELECT 
            m.id,
            m.business_name,
            m.department,
            m.city,
            m.phone,
            m.email,
            m.created_on,
            m.status,
            NVL(SUM(e.revenue), 0) AS total_revenue,
            NVL(SUM(e.employee_count), 0) AS total_employees
         FROM Merchant m
         LEFT JOIN Establishment e ON e.merchant_id = m.id
         WHERE (p_name_filter IS NULL OR LOWER(m.business_name) LIKE '%' || LOWER(p_name_filter) || '%')
           AND (p_city_filter IS NULL OR LOWER(m.city) LIKE '%' || LOWER(p_city_filter) || '%')
           AND (p_status_filter IS NULL OR m.status = p_status_filter)
         GROUP BY 
            m.id, m.business_name, m.department, m.city, 
            m.phone, m.email, m.created_on, m.status
         OFFSET p_offset ROWS FETCH NEXT p_limit ROWS ONLY;

      RETURN l_cursor;
   END get_merchants;


   PROCEDURE create_merchant(p_business_name IN VARCHAR2, 
                             p_department IN VARCHAR2, 
                             p_city IN VARCHAR2, 
                             p_phone IN VARCHAR2, 
                             p_email IN VARCHAR2, 
                             p_status IN VARCHAR2, 
                             p_created_by IN VARCHAR2,
                             o_error_code OUT NUMBER, 
                             o_error_message OUT VARCHAR2) IS
   BEGIN
      IF p_business_name IS NULL OR LENGTH(p_business_name) > 100 THEN
         o_error_code := 1;
         o_error_message := 'Invalid business name';
         RETURN;
      END IF;

      IF p_department IS NULL OR LENGTH(p_department) > 50 THEN
         o_error_code := 2;
         o_error_message := 'Invalid department';
         RETURN;
      END IF;

      IF p_city IS NULL OR LENGTH(p_city) > 50 THEN
         o_error_code := 3;
         o_error_message := 'Invalid city';
         RETURN;
      END IF;

      IF p_email IS NOT NULL AND NOT REGEXP_LIKE(p_email, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$') THEN
         o_error_code := 4;
         o_error_message := 'Invalid email format';
         RETURN;
      END IF;

      INSERT INTO Merchant (business_name, department, city, phone, email, status, created_on, created_by)
      VALUES (p_business_name, p_department, p_city, p_phone, p_email, p_status, SYSDATE, p_created_by);

      o_error_code := 0;
      o_error_message := 'Merchant created successfully';
   EXCEPTION
      WHEN OTHERS THEN
         o_error_code := -1;
         o_error_message := 'Error creating merchant: ' || SQLERRM;
   END create_merchant;


   PROCEDURE update_merchant(p_id IN NUMBER,
                              p_business_name IN VARCHAR2, 
                              p_department IN VARCHAR2, 
                              p_city IN VARCHAR2, 
                              p_phone IN VARCHAR2, 
                              p_email IN VARCHAR2, 
                              p_status IN VARCHAR2, 
                              p_updated_by IN VARCHAR2,
                              o_error_code OUT NUMBER, 
                              o_error_message OUT VARCHAR2) IS
   BEGIN
      IF p_id IS NULL THEN
         o_error_code := 1;
         o_error_message := 'Merchant ID is required';
         RETURN;
      END IF;

      IF p_email IS NOT NULL AND NOT REGEXP_LIKE(p_email, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$') THEN
         o_error_code := 2;
         o_error_message := 'Invalid email format';
         RETURN;
      END IF;

      UPDATE Merchant
      SET business_name = NVL(p_business_name, business_name),
            department = NVL(p_department, department),
            city = NVL(p_city, city),
            phone = NVL(p_phone, phone),
            email = NVL(p_email, email),
            status = NVL(p_status, status),
            updated_on = SYSDATE,
            updated_by = p_updated_by
      WHERE id = p_id;

      IF SQL%ROWCOUNT = 0 THEN
         o_error_code := 3;
         o_error_message := 'Merchant not found or no changes made';
         RETURN;
      END IF;

      o_error_code := 0;
      o_error_message := 'Merchant updated successfully';
   EXCEPTION
      WHEN OTHERS THEN
         o_error_code := -1;
         o_error_message := 'Error updating merchant: ' || SQLERRM;
   END update_merchant;


   PROCEDURE delete_merchant(p_id IN NUMBER, 
                             o_error_code OUT NUMBER, 
                             o_error_message OUT VARCHAR2) IS
   BEGIN
      IF p_id IS NULL THEN
         o_error_code := 1;
         o_error_message := 'Merchant ID is required';
         RETURN;
      END IF;

      DELETE FROM Merchant WHERE id = p_id;

      IF SQL%ROWCOUNT = 0 THEN
         o_error_code := 2;
         o_error_message := 'Merchant not found';
         RETURN;
      END IF;

      o_error_code := 0;
      o_error_message := 'Merchant deleted successfully';
   EXCEPTION
      WHEN OTHERS THEN
         o_error_code := -1;
         o_error_message := 'Error deleting merchant: ' || SQLERRM;
   END delete_merchant;

END PKG_MERCHANT;
