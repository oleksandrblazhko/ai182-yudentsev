CREATE OR REPLACE FUNCTION get_data(model_name VARCHAR, v_user_name VARCHAR, v_token VARCHAR)
    RETURNS TABLE(c_id INTEGER, model VARCHAR, year INTEGER)
    LANGUAGE plpgsql
as
$$
DECLARE
 str VARCHAR;
BEGIN
    CALL sso_control(v_user_name,v_token);
 str := 'SELECT * FROM car WHERE name = ''' || model_name || '''';
 RAISE NOTICE 'Query=%', str;
 RETURN QUERY EXECUTE str;
END;
$$;
