-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: public
-- Object: upd_template_component_web_app(jsonb)
-- Type: FUNCTION

-- Name: upd_template_component_web_app(jsonb); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.upd_template_component_web_app(p_webjson jsonb, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
declare

v_selector_id text;
v_show_in_web boolean;
v_show_in_app boolean;
v_show_in_mweb boolean;

begin

select p_webjson-> inputjson ->> 'selector_id',
		   p_webjson-> inputjson ->> 'show_in_web',
			p_webjson-> inputjson ->> 'show_in_app',
			p_webjson-> inputjson ->> 'show_in_mweb'
	into v_selector_id,
		 v_show_in_web,
		 v_show_in_app,
		 v_show_in_mweb;


	

UPDATE labuww.labuww_template_component_map
    SET show_in_web = case when v_show_in_web = 'true' then 1 else 0 end,
		show_in_app = case when v_show_in_app = 'true' then 1 else 0 end,
		show_in_mweb = case when v_show_in_mweb = 'true' then 1 else 0 end
	
    WHERE tcmap_guid = v_selector_id;


p_result:=1;

end;
$$;


--
