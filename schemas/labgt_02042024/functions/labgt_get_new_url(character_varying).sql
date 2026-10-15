-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt_02042024
-- Object: labgt_get_new_url(character varying)
-- Type: FUNCTION

-- Name: labgt_get_new_url(character varying); Type: FUNCTION; Schema: labgt_02042024; Owner: -
--

CREATE FUNCTION labgt_02042024.labgt_get_new_url(p_old_url character varying, OUT p_new_url character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$ 

declare
v_asset_id numeric;
v_asset_type_id numeric;
v_old_alias varchar;

begin

       v_old_alias :=upper(p_old_url);

          select 
          asset_id ,
          asset_type_id
          into v_asset_id,v_asset_type_id
          from labgt.labgt_redirect 
          where upper(old_alias)=v_old_alias;
          
          select 
          new_alias into p_new_url
          from labgt.labgt_redirect 
          where 
          asset_id=v_asset_id
          and asset_type_id=v_asset_type_id
          and  alias_number=(select max(alias_number)from labgt.labgt_redirect 
                             where asset_id=v_asset_id
                              and asset_type_id=v_asset_type_id);

end;
 

 $$;


--
