-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labyho
-- Object: labyho_get_flowx_listing_r(numeric, numeric, character varying)
-- Type: FUNCTION

-- Name: labyho_get_flowx_listing_r(numeric, numeric, character varying); Type: FUNCTION; Schema: labyho; Owner: -
--

CREATE FUNCTION labyho.labyho_get_flowx_listing_r(p_pagenumber numeric, p_itemnumber numeric, p_team_source_id character varying, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$ 
declare
v_fromrownumber numeric;
v_torownumber numeric;
begin

        v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
		v_torownumber := (p_pagenumber * p_itemnumber);
if p_team_source_id is not null then 

select ('{"data":'||json_agg(flowx_json)::text||'}') ::jsonb into p_data
  from (
select  flowx_json,row_number() over (order by created_date desc) as rn 
	  from labyho.labyho_flowx_social
where source_object_id=p_team_source_id
) tab
where rn between v_fromrownumber and v_torownumber
;
end if;
p_result:=1;

exception when others then 
p_result:=-1;

end;

 
$$;


--
