-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtri
-- Object: labtri_get_regex_page_data_r()
-- Type: FUNCTION

-- Name: labtri_get_regex_page_data_r(); Type: FUNCTION; Schema: labtri; Owner: -
--

CREATE FUNCTION labtri.labtri_get_regex_page_data_r(OUT p_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $_$
--do
--$$
 

declare

begin

insert into siwaf.siwaf_client_logs(api_error_log_id,log_method_name,
log_error_message,log_guid,error_json,created_date,client_name,log_type)
values (nextval('siwaf.seq_siwaf_api_error_log_id'),'try_log_tri','logs',uuid_generate_v4(),p_json,current_timestamp,'labtri','logs');

select json_agg(x) from
(select page_id,alias,asset_type_id,title,meta_info
 from labtri.labtri_page
where meta_info->>'is_regex'='1' and is_published = 1)x
into p_json;
 

end;
$_$;


--
