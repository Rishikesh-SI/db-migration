-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: _get_comment_listing(character varying, character varying, numeric, numeric, numeric)
-- Type: FUNCTION

-- Name: _get_comment_listing(character varying, character varying, numeric, numeric, numeric); Type: FUNCTION; Schema: siwaf; Owner: -
--

CREATE FUNCTION siwaf._get_comment_listing(p_schema_prefix character varying, p_search_keyword character varying, p_pagenumber numeric, p_itemnumber numeric, p_is_spam numeric, OUT p_data jsonb, OUT p_result numeric) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare
	v_search_keyword text;
	v_fromrownumber numeric;
	v_torownumber numeric;
    v_search_query text :=' ';
    v_count numeric;
	
	v_spam_query text := ' ';
  
begin

	v_search_keyword := p_search_keyword;
    
    if v_search_keyword is not null then
 		v_search_query:=' and upper(a.comment_text) like ''%'||upper(v_search_keyword)||'%'' ';
 	end if;
	
	if p_is_spam = 1 then
	
 		v_spam_query:=' and is_spam = 1 ';
		
 	end if;

    
    v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
  	v_torownumber   := (p_pagenumber * p_itemnumber);
    
    	execute	'select cnt,''{"data":[''||string_agg(row_to_json(row)::text,'','')||'']}''
              	 from ( select  a.user_asset_reaction_id,a.comment_text,
				        row_number() over (order by a.user_asset_reaction_id ) as rno,
                 		count(1) over() as cnt
              	 		from '||p_schema_prefix||'.'||p_schema_prefix||'_user_asset_reaction a
              	 		where  a.reaction_id = 4 '||v_spam_query||' '||v_search_query||' )row
                 where rno between  '|| v_fromrownumber ||'and '||v_torownumber||'
                 group by cnt' 
     	into v_count,p_data;
             
        p_result:= v_count;
             
end;

$$;


--
