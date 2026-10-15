-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: public
-- Object: update_skill_count()
-- Type: FUNCTION

-- Name: update_skill_count(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.update_skill_count() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
    if old.test_id = new.test_id then 
	raise notice '% old % new',new.test_id,old.test_id;
    update test_1
	set name='update'
	where test_id=new.test_id;
	else
	insert into test_1 
	select new.test_id,'tring';
	end if;
	
	
	return new;
end;
$$;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
