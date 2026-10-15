-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_beta_22042024
-- Object: labmi_get_spam_comment_listing(jsonb)
-- Type: FUNCTION

-- Name: labmi_get_spam_comment_listing(jsonb); Type: FUNCTION; Schema: labmi_beta_22042024; Owner: -
--

CREATE FUNCTION labmi_beta_22042024.labmi_get_spam_comment_listing(p_json jsonb, OUT p_data jsonb, OUT p_result numeric) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare
    /*
	{
  "data": {
    "search_keyword": "xyz",
    "pagenumber": 1,
    "itemnumber": 10
  }
}
	*/

	v_search_keyword text;
	v_fromrownumber numeric;
	v_torownumber numeric;
    v_search_query text :=' ';
    v_count numeric;
	p_schema_prefix text := 'labmi';
	v_pagenumber numeric;
	v_itemnumber numeric;
  
begin
     
    select p_json->'data'->>'search_keyword',
		   p_json->'data'->>'pagenumber',
		   p_json->'data'->>'itemnumber'
	into   v_search_keyword,
	       v_pagenumber,
		   v_itemnumber; 
    
    if v_search_keyword is not null then
 		v_search_query:=' and upper(a.comment_text) like ''%'||upper(v_search_keyword)||'%'' ';
 	end if;

    
    v_fromrownumber := (v_pagenumber * v_itemnumber - (v_itemnumber - 1));
  	v_torownumber   := (v_pagenumber * v_itemnumber);
    
    	execute	'select cnt,''{"data":[''||string_agg(row_to_json(row)::text,'','')||'']}''
              	 from ( select  a.user_asset_reaction_id,a.comment_text,a.message,row_number() over (order by a.user_asset_reaction_id ) as rno,
                 		count(1) over() as cnt
              	 		from '||p_schema_prefix||'.'||p_schema_prefix||'_user_asset_reaction a
              	 		where  a.reaction_id = 4 and is_spam =  1 '||v_search_query||' )row
                 where rno between  '|| v_fromrownumber ||'and '||v_torownumber||'
                 group by cnt' 
     	into v_count,p_data;
             
        p_result:= v_count;
             
end;

$$;


--
