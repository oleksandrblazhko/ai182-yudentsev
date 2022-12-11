CREATE OR REPLACE FUNCTION get_data(model_name VARCHAR)
RETURNS TABLE
(c_id INTEGER, model VARCHAR, year VARCHAR)
AS $$
DECLARE
	str VARCHAR;
BEGIN
	str := 'SELECT * FROM car WHERE model = ''' || 
		model_name || '''';
	RAISE NOTICE 'Query=%',str;
	RETURN QUERY EXECUTE str;
END;
$$ LANGUAGE plpgsql;
