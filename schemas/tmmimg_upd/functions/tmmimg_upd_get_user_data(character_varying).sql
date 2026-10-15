-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmmimg_upd
-- Object: tmmimg_upd_get_user_data(character varying)
-- Type: FUNCTION

-- Name: tmmimg_upd_get_user_data(character varying); Type: FUNCTION; Schema: tmmimg_upd; Owner: -
--

CREATE FUNCTION tmmimg_upd.tmmimg_upd_get_user_data(p_user_guid character varying, OUT p_user_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$ 

declare

begin
	select '{"data":'||row_to_json(row)||'}' into p_user_data
	from (select coalesce(wu.social_user_name,wu.user_full_name) social_user_name,coalesce(wu.customized_bib_name,wu.social_user_name,wu.user_full_name) customized_bib_name, 
		  wu.email_id,wu.profile_picture_url,td.bib_number,wu.dob,wu.city,wu.gender,
			max(tl.user_level) user_level
	from tmmimg_upd.tmmimg_upd_web_user wu
	join tmmimg_upd.tmmimg_upd_tigertrack_data td on (wu.social_user_name = td.social_user_id or wu.social_id = td.social_user_id)
	join tmmimg_upd.tmmimg_upd_tigertrack_user_level tl on td.social_user_id = tl.social_user_id 
	where wu.user_guid = p_user_guid
	group by coalesce(wu.social_user_name,wu.user_full_name),wu.email_id,wu.profile_picture_url,td.bib_number,
		  coalesce(wu.customized_bib_name,wu.social_user_name,wu.user_full_name),wu.dob,wu.city,wu.gender)row;

	-- raise notice '%',p_user_data;
end;

$$;


--
