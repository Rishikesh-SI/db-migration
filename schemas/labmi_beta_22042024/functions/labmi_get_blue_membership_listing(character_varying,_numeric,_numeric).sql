-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_beta_22042024
-- Object: labmi_get_blue_membership_listing(character varying, numeric, numeric)
-- Type: FUNCTION

-- Name: labmi_get_blue_membership_listing(character varying, numeric, numeric); Type: FUNCTION; Schema: labmi_beta_22042024; Owner: -
--

CREATE FUNCTION labmi_beta_22042024.labmi_get_blue_membership_listing(p_searchkeyword character varying, p_pagenumber numeric, p_itemnumber numeric, OUT p_count numeric, OUT p_userjson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare

v_json text;
v_fromrownumber numeric;
v_torownumber numeric ;
v_search_text text;
v_entitysearchquery text := ' ';
v_userjson jsonb;
v_count numeric;
v_available_coupon jsonb;
v_membership_data jsonb;
v_count_1 numeric;
v_membership_data_previous_day jsonb;

begin

v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
    v_torownumber   := (p_pagenumber * p_itemnumber);

if p_searchkeyword is not null then
     
          v_entitysearchquery := ' and (a.email_id = '''||p_searchkeyword||'''
OR a.mobile_no = '''||p_searchkeyword||''')';
   end if ;
   
  select count(1) into v_count
  from  labmi.labmi_web_user
  where campaign_id = 1 and is_verified = 1;
  
  select count(1) into v_count_1
  from  labmi.labmi_web_user
  where campaign_id = 1 and is_verified = 1 
  and created_date between (current_timestamp at time zone 'utc') - '1 day'::interval and current_timestamp at time zone 'utc' ;


execute
'select  array_to_json(array_agg(tab1)) from
(select a.user_full_name,a.email_id,a.mobile_no,s.name state,c.name city,mcc.coupon_code,
row_number() OVER (ORDER BY a.updated_date desc ) AS rno from labmi.labmi_web_user  a
left join waf_master.waf_cities c on a.city_id=c.city_id
left join waf_master.waf_states s on a.state_id=s.state_id
left join labmi.labmi_membership_coupon_code mcc on a.user_guid = mcc.user_guid
where a.campaign_id = 1 and is_verified = 1 '|| v_entitysearchquery || ' )tab1
where rno between '||v_fromrownumber||' and '|| v_torownumber  
into v_json ;

select  array_to_json(array_agg(tab)) into v_available_coupon from
(select product_id, case product_id when 1 then 'Blue'
when 3 then 'Silver'
else 'Gold' end as Membership_name,
count(1)
from labmi.labmi_membership_coupon_code
 where is_used = 0
group by product_id, case product_id when 1 then 'Blue'
when 3 then 'Silver'
else 'Gold' end
order by 1)tab;

select  array_to_json(array_agg(tab1)) into v_membership_data from
(select campaign_id,case campaign_id when 1 then 'Blue'
when 3 then 'Silver'
else 'Gold' end membership_name, count(1)
from labmi.labmi_web_user
where campaign_id is not null
group by campaign_id,case campaign_id when 1 then 'Blue'
when 3 then 'Silver'
else 'Gold' end )tab1;

if v_json is not null then  
v_userjson :=   ('{ "data" : '|| v_json || '}' )::jsonb; --v_json::json;
v_userjson := jsonb_set(v_userjson, '{available_coupon}', v_available_coupon, true);
v_userjson := jsonb_set(v_userjson, '{membership_data}', v_membership_data, true);
v_userjson := jsonb_set(v_userjson, '{verified_blue_user}', v_count::text::jsonb, true);
  else
v_userjson := ('{ "data" : {}}')::jsonb;
  end if ;

p_userjson := v_userjson ;
p_count := v_count ;
   
raise notice '%', p_userjson;
raise notice '%', p_count;

   
end;
$$;


--
