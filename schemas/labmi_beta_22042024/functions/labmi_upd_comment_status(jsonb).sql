-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_beta_22042024
-- Object: labmi_upd_comment_status(jsonb)
-- Type: FUNCTION

-- Name: labmi_upd_comment_status(jsonb); Type: FUNCTION; Schema: labmi_beta_22042024; Owner: -
--

CREATE FUNCTION labmi_beta_22042024.labmi_upd_comment_status(p_json jsonb, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

declare

/*
{
  "data": {
    "asset_id": 1973,
    "asset_type_id": 1,
    "comment_id": 604878,
    "reported_by": "78921686-9582-4666-be2c-3a97f23a4b85",
	"message" : "xyz"
  }
}
*/

   v_asset_id numeric;
   v_reported_by character varying(1000);
   v_asset_type_id numeric;
   v_comment_id numeric;
   v_user_id numeric;
   v_message text;
 

begin
	
	select p_json->'data'->>'asset_id',
		   p_json->'data'->>'asset_type_id',
		   p_json->'data'->>'comment_id',
		   p_json->'data'->>'reported_by',
		   p_json->'data'->>'message'
	into   v_asset_id,
	       v_asset_type_id,
		   v_comment_id,
           v_reported_by,
		   v_message;
		   
		   select user_id into v_user_id from labmi.labmi_web_user
	       where user_guid = v_reported_by;
		   
		 --  raise notice '%',v_comment_id;
		   
		   insert into labmi.labmi_comment_spam(comment_id,asset_id,asset_type_id,reported_by,remarks)
		   values(v_comment_id,v_asset_id,v_asset_type_id,v_user_id,v_message);
		   
		   
		   update labmi.labmi_user_asset_reaction
		   set is_spam = 1 
		   where asset_id = v_asset_id and asset_type_id = v_asset_type_id 
		   and user_asset_reaction_id = v_comment_id;

	
			p_result:= 1;

end;

$$;


--
