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
         GROUP BY 
            m.id, m.business_name, m.department, m.city, 
            m.phone, m.email, m.created_on, m.status
         OFFSET p_offset ROWS FETCH NEXT p_limit ROWS ONLY;

      RETURN l_cursor;
   END get_merchants;
END PKG_MERCHANT;
