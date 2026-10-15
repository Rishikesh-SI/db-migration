-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsaw
-- Object: labsaw_get_unsubscribe_r(text)
-- Type: FUNCTION

-- Name: labsaw_get_unsubscribe_r(text); Type: FUNCTION; Schema: labsaw; Owner: -
--

CREATE FUNCTION labsaw.labsaw_get_unsubscribe_r(p_guid text, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $_$

--do
--$$
declare 
/*p_alias text :='testing-stumped-1';
p_pagenumber numeric:=1;
p_itemnumber numeric:=10;
p_page1_size numeric:=10;
p_entityrole_mapid numeric[]:=array[4,7];
p_assetcount numeric;
p_assetjson jsonb;
----------
*/
v_subscribe numeric;
begin 

select  is_subscribe into v_subscribe
from labsaw.labsaw_contact
where page_flag=3
and contact_guid=p_guid ;

if v_subscribe=0 then 
 p_result :=0 ;
 else p_result :=1; end if;
 

	
-- raise notice '% check ',p_assetjson;

end;

$_$;


--
