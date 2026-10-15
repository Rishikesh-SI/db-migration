-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: labgt_get_daywise_activations(jsonb)
-- Type: FUNCTION

-- Name: labgt_get_daywise_activations(jsonb); Type: FUNCTION; Schema: labgt; Owner: -
--

CREATE FUNCTION labgt.labgt_get_daywise_activations(p_inputjson jsonb, OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare
		/* input of function:-
	
	select * from labgt.labgt_check_mobilenum_exist( 
	'{
  "mobile_no": "8108789945",
  "email_id": "abc@gmail.com",
}') */
	v_user_guid character varying(1000);
	v_count numeric;
	v_user_data jsonb ;
	v_status character varying;
	v_title character varying;
	v_title_alias character varying;
begin
	select p_inputjson->'data'->>'user_guid',
	p_inputjson->'data'->>'status',
	p_inputjson->'data'->>'title_alias'
	into 
	v_user_guid,
	v_status,
	v_title_alias;

	
		
--if (select 1 from labgt.labgt_)	
if (v_status is not null or v_status <> '') then
		 
	 if v_status = 'successful' then
	 
	 raise notice '1';
		 -- raise notice '% ,% ',v_mobile_no,v_email_id;
			select '{"event" :' || json_agg(a) || '}' from 
			(select module_name as title_alias,
			 case 
			 	when module_name = 'watch-video' then 'Day 1'
			 	when module_name = 'play-quiz' then 'Day 3'
			 	when module_name = 'wordle-activity' then 'Day 4'
			 	when module_name = 'decode-message' then 'Day 7'
			 	when module_name = 'play-poll' then 'Day 8'
			 	when module_name = 'fam-wall-upload' then 'Day 9'
			 end
			 as title
			 --,null as image_id_array
			from labgt.labgt_daywise_user_activity dua
			--left join labgt.labgt_asset_list al on dua.asset_id = al.asset_id and dua.asset_type_id = al.asset_type_id
			where user_guid = v_user_guid and module_name not in ('shubman-gill','dandiya-sticks','refer-5-friends')
			and is_successful = 1
			 
			 
			union all
			 
-- 			select module_name as title_alias from
			--(
			 
			 
				select  module_name as title_alias,
			 'dandiya-sticks' as title
			from labgt.labgt_daywise_user_activity dua
			join labgt.labgt_dynamic_content_additional_info_data dcad on dcad.slug_url = dua.module_name
			--left join labgt.labgt_asset_list al on dua.asset_id = al.asset_id 
--			and dua.asset_type_id = al.asset_type_id
			where user_guid = v_user_guid and module_name in ('dandiya-sticks')
			and is_successful=1
			group by user_guid,module_name,additional_info
			having count(daywise_user_activity_id) >= (dcad.additional_info->'additional_info'->>'img_count')::numeric --)a,
-- 			labgt.labgt_dynamic_content_additional_info_data dcad
-- 			where a.image_id_array::int[] @> dcad.content_id_array and a.module_name = dcad.slug_url
			 
			union all
			 
			 select  module_name as title_alias,
			 'shubman-gill' as title
			from labgt.labgt_daywise_user_activity dua
			join labgt.labgt_dynamic_content_additional_info_data dcad on dcad.slug_url = dua.module_name
			where user_guid = v_user_guid and module_name in ('shubman-gill')
			and is_successful=1
			group by user_guid,module_name,additional_info
			having count(daywise_user_activity_id) >= (dcad.additional_info->'additional_info'->>'img_count')::numeric
			 
			union all
			 
			select module_name as title_alias,
			'Day 5' as title
			 --,null as image_id_array
			from labgt.labgt_daywise_user_activity dua
			--left join labgt.labgt_asset_list al on dua.asset_id = al.asset_id and dua.asset_type_id = al.asset_type_id
			where user_guid = v_user_guid and module_name in ('refer-5-friends')
			and is_successful = 1
			group by user_guid,module_name
			having count(daywise_user_activity_id)>=3
			) a 
			into v_user_data;
			raise notice 'v_user_data %',v_user_data;
	elsif (v_status = 'unsuccessful') then
			
			select '{"event" :' || json_agg(a) || '}' from 
			(select slug_url as title_alias,
			 case 
			 when slug_url = 'watch-video' then 'Day 1'
			 when slug_url = 'play-quiz' then 'Day 3' 
			 when slug_url = 'wordle-activity' then 'Day 4'
			 when slug_url = 'decode-message' then 'Day 7'
			 when slug_url = 'play-poll' then 'Day 8'
			 when slug_url = 'fam-wall-upload' then 'Day 9'
			 end as title
			from labgt.labgt_dynamic_content_additional_info_data dcad 
			left join labgt.labgt_daywise_user_activity dua on dcad.slug_url = dua.module_name 
			--left join labgt.labgt_asset_list al on dua.asset_id = al.asset_id and dua.asset_type_id = al.asset_type_id
			where user_guid = v_user_guid and module_name not in ('shubman-gill','dandiya-sticks','refer-5-friends')
			and (is_successful = 0 or is_successful is null)
			 
			union all
			 
			select  module_name as title_alias,
			 case 
			 	when module_name = 'shubman-gill' then 'Day 6'
			 	when module_name = 'dandiya-sticks' then 'Day 2'
			 end as title
			from labgt.labgt_daywise_user_activity dua
			--left join labgt.labgt_asset_list al on dua.asset_id = al.asset_id 
--			and dua.asset_type_id = al.asset_type_id
			where user_guid = v_user_guid and module_name in ('shubman-gill','dandiya-sticks')
			and (is_successful = 0 or is_successful is null)
			group by user_guid,module_name
			 
			union all
			 
			select module_name as title_alias,
			'Day 5' as title
			from labgt.labgt_daywise_user_activity dua
			--left join labgt.labgt_asset_list al on dua.asset_id = al.asset_id and dua.asset_type_id = al.asset_type_id
			where user_guid = v_user_guid and module_name in ('refer-5-friends')
			and (is_successful = 0 or is_successful is null)
			group by user_guid,module_name
			) a 
			into v_user_data;
			
	elsif(v_status = 'partial') then
			
			raise notice 'v_status %',v_status;
			
			select '{"event" :' || json_agg(a) || '}' from 
			(
			select  module_name as title_alias,array_agg(dua.asset_id) as image_id_array,null::bigint as count_of_referral,
			 'dandiya-sticks' as title
			from labgt.labgt_daywise_user_activity dua
			join labgt.labgt_dynamic_content_additional_info_data dcad on dcad.slug_url = dua.module_name
			where user_guid = v_user_guid and module_name in ('dandiya-sticks')
			and is_successful=1
			group by user_guid,module_name,additional_info
			having count(daywise_user_activity_id) < (dcad.additional_info->'additional_info'->>'img_count')::numeric
				
			union all 
				
			select  module_name as title_alias,array_agg(dua.asset_id) as image_id_array,null::bigint as count_of_referral,
			 'shubman-gill' as title
			from labgt.labgt_daywise_user_activity dua
			join labgt.labgt_dynamic_content_additional_info_data dcad on dcad.slug_url = dua.module_name
			where user_guid = v_user_guid and module_name in ('shubman-gill')
			and is_successful=1
			group by user_guid,module_name,additional_info
			having count(daywise_user_activity_id) < (dcad.additional_info->'additional_info'->>'img_count')::numeric	
				
			union all
				
			select module_name as title_alias,null as image_id_array,count(daywise_user_activity_id) as count_of_referral,
			'Day 5' as title
			from labgt.labgt_daywise_user_activity dua
			where user_guid = v_user_guid and module_name in ('refer-5-friends')
			and is_successful = 1
			group by user_guid,module_name
			having count(daywise_user_activity_id)<3
			) a 
			into v_user_data;

	end if;	
else

	if(v_title_alias = 'dandiya-sticks' or v_title_alias = 'shubman-gill' or v_title_alias = 'refer-5-friends') then
		with cte1 as(
			select module_name,count(daywise_user_activity_id) as count,array_agg(ua.asset_id) as image_id_array
			from labgt.labgt_daywise_user_activity ua
			where module_name = v_title_alias and is_successful = 1 and user_guid = v_user_guid
			group by user_guid,module_name),cte2 as(
				select slug_url,img_count as count from labgt.labgt_dynamic_content_additional_info_data dcad
	)
		select '{"event" :' || json_agg(a) || '}' from
		(select 
		case when cte1.count >= cte2.count then 'successful' else 'partial' end
		as status,case when module_name != 'refer-5-friends' then image_id_array else null end as image_id_array
		from cte1
		join cte2 on cte1.module_name = cte2.slug_url)a into v_user_data;
	else
		
		with cte1 as(
		select  is_successful
		from labgt.labgt_daywise_user_activity where module_name = v_title_alias 
		 and user_guid = v_user_guid)
		select '{"event" :' || json_agg(a) || '}' from(
		select case when cte1.is_successful = 1 then 'successful' else 'unsuccessful' end
		as status
		from cte1)a into v_user_data;
	end if;
end if;
-- 	select count(1)
-- 	from labgt.labgt_daywise_user_activity dua
-- 	where user_guid = v_user_guid
-- 	group by user_guid;
raise notice 'v_user_data %',coalesce(v_user_data,'{}');

	p_data := coalesce(v_user_data,'{}');

    
	

end;
$$;


--
