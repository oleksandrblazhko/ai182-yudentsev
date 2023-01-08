CREATE OR REPLACE FUNCTION user_register_secure(
    v_user_name varchar, 
    v_password varchar
)
RETURNS INTEGER
AS $$
BEGIN
	IF NOT EXISTS (SELECT FROM months WHERE passname = v_password) THEN
  IF password_is_correct_v3(v_password) THEN
  INSERT INTO users (user_name,password_hash) VALUES (v_user_name, md5(v_password)); 
  RETURN 1;
  ELSE
			RAISE NOTICE 'Пароль = % некоректний!', v_password;
			RETURN -1;
  END IF;
	ELSE 
		RAISE NOTICE 'Пароль = % є слабким!', v_password;
		RETURN -1;
	END IF;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION password_is_correct_v3(password varchar) 
RETURNS BOOLEAN 
AS $$ 
BEGIN 
RETURN password SIMILAR TO '(\S{15,20}|[^0-9]{1,10}|[^a-z]{4,10}|[^A-Z]{4,10}|[^!@#$%^&*]{2,10})'; 
END; 
$$ LANGUAGE plpgsql;
