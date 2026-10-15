-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_beta_22042024
-- Object: labmi_check_slugurl(numeric, character varying)
-- Type: FUNCTION

-- Name: labmi_check_slugurl(numeric, character varying); Type: FUNCTION; Schema: labmi_beta_22042024; Owner: -
--

CREATE FUNCTION labmi_beta_22042024.labmi_check_slugurl(p_assetid numeric, p_slugurl character varying, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $_$ 

declare
	
     v_query varchar(30) := ' ';
     v_slugcount numeric;
     v_slugurl varchar(4000) := upper(p_slugurl);
     
begin

	p_result := 0;
     
	if p_assetid is not null then
     	
          v_query := ' and asset_id <> $1 ';
              
     end if;
     
     execute 'select count(1)
              from   labmi.labmi_asset_list
              where  upper(title_alias) = $2'
              ||v_query
              into   strict v_slugcount
	using    p_assetid, v_slugurl;
	
     if v_slugcount > 0 then
		p_result := 1;
	end if;
     
exception
	
     when others then
     	p_result := -1;

end;

 $_$;


--
