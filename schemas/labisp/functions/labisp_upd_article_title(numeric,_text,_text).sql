-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labisp
-- Object: labisp_upd_article_title(numeric, text, text)
-- Type: FUNCTION

-- Name: labisp_upd_article_title(numeric, text, text); Type: FUNCTION; Schema: labisp; Owner: -
--

CREATE FUNCTION labisp.labisp_upd_article_title(p_opt_type numeric, p_old_str text, p_new_str text, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 
declare
v_count numeric;
begin

update labisp.labisp_article
set  title =replace(title,p_old_str,p_new_str),
 title_alias=replace(title_alias,lower(p_old_str),lower(p_new_str)),
 browser_title=replace(browser_title,p_old_str,p_new_str),
 short_title=replace(short_title,p_old_str,p_new_str)
 where title like '%'||p_old_str||'%';
GET DIAGNOSTICS v_count = ROW_COUNT;

update labisp.labisp_asset_list
set  asset_title =replace(asset_title,p_old_str,p_new_str),
 title_alias=replace(title_alias,lower(p_old_str),lower(p_new_str)),
 short_desc=replace(short_desc,p_old_str,p_new_str),
 short_title=replace(short_title,p_old_str,p_new_str)
 where asset_title like '%'||p_old_str||'%';
 
   

if v_count>0
then p_result=v_count;
else
p_result=0;
end if;

end;
$$;


--
