CREATE OR REPLACE FUNCTION get_data(model_name VARCHAR)
RETURNS TABLE
(c_id INTEGER, model VARCHAR, year INTEGER)
AS $$
DECLARE
	str VARCHAR;
BEGIN
	str := 'SELECT * FROM car WHERE model = $1';
	RAISE NOTICE 'Query=%',str;
	RETURN QUERY EXECUTE str USING model_name;
END;
$$ LANGUAGE plpgsql;
