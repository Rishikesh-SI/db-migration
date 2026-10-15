-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmm
-- Object: tmm_get_user_data(character varying)
-- Type: FUNCTION

-- Name: tmm_get_user_data(character varying); Type: FUNCTION; Schema: tmm; Owner: -
--

CREATE FUNCTION tmm.tmm_get_user_data(p_user_guid character varying, OUT p_user_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$ 

declare

begin
	select '{"data":'||row_to_json(row)||'}' into p_user_data
	from (select coalesce(wu.social_user_name,wu.user_full_name) social_user_name,coalesce(wu.customized_bib_name,wu.social_user_name,wu.user_full_name) customized_bib_name, 
		  wu.email_id,wu.profile_picture_url,td.bib_number,wu.dob,wu.city,wu.gender,
			max(tl.user_level) user_level
	from tmm.tmm_web_user wu
	join tmm.tmm_tigertrack_data td on (wu.social_user_name = td.social_user_id or wu.social_id = td.social_user_id)
	join tmm.tmm_tigertrack_user_level tl on td.social_user_id = tl.social_user_id
	where wu.user_guid = p_user_guid
	group by coalesce(wu.social_user_name,wu.user_full_name),wu.email_id,wu.profile_picture_url,td.bib_number,
		  coalesce(wu.customized_bib_name,wu.social_user_name,wu.user_full_name),wu.dob,wu.city,wu.gender)row;

	-- raise notice '%',p_user_data;
end;

$$;


--
