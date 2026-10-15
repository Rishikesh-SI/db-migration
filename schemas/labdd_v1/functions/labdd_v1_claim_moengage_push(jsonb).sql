-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdd_v1
-- Object: labdd_v1_claim_moengage_push(jsonb)
-- Type: FUNCTION

-- Name: labdd_v1_claim_moengage_push(jsonb); Type: FUNCTION; Schema: labdd_v1; Owner: -
--

CREATE FUNCTION labdd_v1.labdd_v1_claim_moengage_push(p_json jsonb, OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $_$

/*
select * from labdd_v1.labdd_v1_claim_moengage_push
(
    '{
    "data": {
        "custom_ids": [1, 2, 3]
    }
}'
);
...
*/

declare

    v_ids bigint[];

begin

    select array_agg(value::bigint)
      into v_ids
      from jsonb_array_elements_text(p_json->'data'->'custom_ids') as value
     where value ~ '^[0-9]+$';

    if v_ids is null or array_length(v_ids, 1) is null then
        p_data := jsonb_build_object('data', '[]'::jsonb);
        return;
    end if;


    with claimed as (
        update labdd_v1.labdd_v1_custom_web_json
           set datajson = jsonb_set(datajson,
                                    '{data,moengage_pushed_at}',
                                    to_jsonb(to_char(current_timestamp at time zone 'UTC',
                                                     'YYYY-MM-DD"T"HH24:MI:SS"Z"'))),
               updated_date = current_timestamp
         where custom_id = any(v_ids)
           and lower(module_name) = 'dadas_delhi_campaign'
           and datajson->'data'->>'status' = '1'
           and datajson->'data'->'moengage_pushed_at' is null
        returning custom_id, user_guid, datajson
    )
    select jsonb_build_object('data', coalesce(jsonb_agg(
               jsonb_build_object(
                   'custom_id', custom_id,
                   'user_guid', user_guid,
                   'mobile_no', datajson->'data'->'user_info'->>'mobile_no',
                   'email_id',  datajson->'data'->'user_info'->>'email_id',
                   'full_name', datajson->'data'->'wall_info'->>'full_name',
                   'city',      datajson->'data'->'wall_info'->>'city',
                   'message',   datajson->'data'->'wall_info'->>'message')
               order by custom_id), '[]'::jsonb))
      into p_data
      from claimed;

end;

$_$;


--
