-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labfih
-- Object: labfih_get_cms_user_detail(numeric)
-- Type: FUNCTION

-- Name: labfih_get_cms_user_detail(numeric); Type: FUNCTION; Schema: labfih; Owner: -
--

CREATE FUNCTION labfih.labfih_get_cms_user_detail(p_user_id numeric, OUT p_result numeric, OUT p_userjson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $_$
--do
--$$
declare
   
	/*
    p_articlecount numeric;
	
	{
	"page_number":"1",
	"item_number":"10",
	"searchkeyword":""
	}
	
	*/

begin

     
	 select row_to_json(x) into p_userjson
	 from
	 (select wu.user_id,first_name,last_name,created_date,wu.user_guid,age_group,d.name as country,
	 case when a.platform_type in (0,1) then 'Web'
		  when a.platform_type in (2) then 'Andriod'
		  when a.platform_type in (3) then 'IOS' end as source
		  
		from labfih.labfih_web_user wu
		join labfih.labfih_web_user_audit a
		on wu.user_guid=a.user_guid		
		left join waf_master.waf_countries d
		on wu.country_id=d.country_id
		where wu.user_id=221
	    and a.option_type = 2
		)x;
	
	if p_userjson is not null then
		p_result:=1;
	end if;	
	
	
	if p_result is null then 
	p_userjson :='{}';
	
	end if;
	--raise notice '% check count',p_usercount;
	-- raise notice '% json ',p_userjson;
end;
$_$;


--
