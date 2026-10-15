-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: labmi_dashboard_old(numeric)
-- Type: FUNCTION

-- Name: labmi_dashboard_old(numeric); Type: FUNCTION; Schema: labmi; Owner: -
--

CREATE FUNCTION labmi.labmi_dashboard_old(p_opt_type numeric, OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

declare
v_view jsonb;
v_share jsonb;
v_pichart_data jsonb;
v_gender_data jsonb;
v_total_user_data jsonb;
v_active_user jsonb;
v_user_response jsonb;
v_popular_post jsonb;
v_total_post numeric;
v_data jsonb ;
v_dob jsonb;
v_pop_emoji jsonb ;

begin

if p_opt_type = 1 then

v_data:= '{"Most_view":null,"Most_share":null,"pichart_data":null}';

execute'select ''[''||string_agg(row_to_json(tab)::text,'','')||'']''
 	  from (select a.asset_id,a.asset_type_id,b.asset_title,count(a.asset_id)as total from labmi.labmi_asset_view_trac a
             left join labmi.labmi_asset_list b on a.asset_id = b.asset_id and a.asset_type_id = b.asset_type_id
             where a.is_action = ''view'' and a.asset_type_id=1 and b.is_published = 1
             group by a.asset_id,a.asset_type_id,b.asset_title
             order by total desc
             limit 10)tab'
into v_view;

if v_view is not null then
		v_data := jsonb_set(v_data::jsonb,'{Most_view}',v_view,true);
	end if;
     
execute'select ''[''||string_agg(row_to_json(tab)::text,'','')||'']''
 	  from (select a.asset_id,a.asset_type_id,b.asset_title,count(a.asset_id)as total from labmi.labmi_asset_view_trac a
             join labmi.labmi_asset_list b on a.asset_id = b.asset_id and a.asset_type_id = b.asset_type_id
             where a.is_action = ''share'' and b.is_published = 1
		   group by a.asset_id,a.asset_type_id,b.asset_title
		   order by total desc
             limit 10)tab'
into v_share;

if v_share is not null then
		v_data := jsonb_set(v_data::jsonb,'{Most_share}',v_share,true);
	end if;

with cte_data as(select a.asset_id,a.asset_type_id,b.asset_title,count(a.asset_id)as total from labmi.labmi_asset_view_trac a
left join labmi.labmi_asset_list b on a.asset_id = b.asset_id and a.asset_type_id = b.asset_type_id
where a.is_action = 'share' and b.is_published = 1
group by a.asset_id,a.asset_type_id,b.asset_title
order by total desc
limit 10)
select '['||string_agg(row_to_json(tab)::text,',')||']' into v_pichart_data
        from (select b.share,count(1) from cte_data a
              left join labmi.labmi_asset_view_trac b on a.asset_id = b.asset_id and a.asset_type_id = b.asset_type_id
              where b.is_action = 'share'
group by  b.share)tab;

if v_pichart_data is not null then
		v_data := jsonb_set(v_data::jsonb,'{pichart_data}',v_pichart_data,true);
	end if;
     
end if;

execute 'select ''[''||string_agg(row_to_json(tab)::text,'','')||'']'' from (
select count(1),url,player_id,entity_name from ( 
select *,NULLIF(regexp_replace(share, ''\D'','''',''g''), '''')::numeric as player_id 
from labmi.labmi_asset_view_trac 
where is_action=''download'' 
and share <>''Jersey Campaign''
and NULLIF(regexp_replace(share, ''\D'','''',''g''), '''')::numeric is not null
and url not like ''%.zip%''
) tab
join labmi.labmi_entity_role_map a
on a.source_object_id=tab.player_id::text
join labmi.labmi_entity_master b 
on a.entity_master_id=b.entity_master_id
group by url,player_id,entity_name
order by  count(1) desc
limit 10)tab'
into v_pop_emoji;

if v_pop_emoji is not null  then
v_data := jsonb_set(v_data::jsonb,'{popular_emoji}',v_pop_emoji,true);
end if;

if p_opt_type = 2 then

v_data:= '{"Gender_data":null,"total_user":null}';

execute'select ''[''||string_agg(row_to_json(tab)::text,'','')||'']''
 	  from (select coalesce (gender,''NA'') as gender,count(1) from labmi.labmi_web_user
             group by coalesce (gender,''NA'')
             )tab'
into v_gender_data;

if v_gender_data is not null then
		v_data := jsonb_set(v_data::jsonb,'{Gender_data}',v_gender_data,true);
	end if;
     
execute'select ''[''||string_agg(row_to_json(tab)::text,'','')||'']''
 	  from (select a.user,user_count,total_count,round((user_count/total_count)*100,2)percent
 from (select case client_id when 2 then ''FB''
   	        when 3 then ''Twitter''
             when 4 then ''Google''
             else ''Custom'' end as User ,count(1)::numeric as user_count,(select count(1) from labmi.labmi_web_user )::numeric as total_count from labmi.labmi_web_user
             group by case client_id when 2 then ''FB''
             when 3 then ''Twitter''
             when 4 then ''Google''
             else ''Custom'' end)a
             )tab'
into v_total_user_data;

if v_total_user_data is not null then
		v_data := jsonb_set(v_data::jsonb,'{total_user}',v_total_user_data,true);
	end if;

select '['||string_agg(row_to_json(tab)::text,',')||']' into v_dob
from (select dob from labmi.labmi_web_user)tab;

if v_dob is not null then
		v_data := jsonb_set(v_data::jsonb,'{dob}',v_dob,true);
end if;

end if;
if p_opt_type = 3 then

v_data:= '{"active_user":null,"user_response":null,"popular_post":null}';

execute'select ''[''||string_agg(row_to_json(tab)::text,'','')||'']''
 	  from (select b.user_id,c.user_full_name,b.comment_count,b.reaction_count,(b.comment_count+b.reaction_count)total from 
(select user_id,sum(comment::numeric)comment_count,sum(reaction::numeric)reaction_count  from
(select user_id,0 as comment,count(user_id) as reaction from labmi.labmi_asset_comment_reaction
group by user_id
union all
select user_id,count(user_id),0  from labmi.labmi_user_asset_reaction
group by user_id)a
group by user_id)b
join labmi.labmi_web_user c on b.user_id= c.user_id
order by total desc
limit 10)tab'
into v_active_user;

if v_active_user is not null then
		v_data := jsonb_set(v_data::jsonb,'{active_user}',v_active_user,true);
	end if;
     
execute 'select count(1) total_post from (select asset_id,asset_type_id 
                                          from labmi.labmi_user_asset_reaction
                                          group by asset_id,asset_type_id )a'
into v_total_post;

if v_total_post is not null then
		v_data := jsonb_set(v_data::jsonb,'{total_post}',v_total_post::text::jsonb, true);
	end if;

execute'select ''[''||string_agg(row_to_json(tab)::text,'','')||'']''
 	   from (select reaction_id,reaction_count, total_count,round((reaction_count/total_count)*100,2)percent 
       		from(select reaction_id ,count(1)::numeric as reaction_count,
                       (select count(1) from labmi.labmi_user_asset_reaction where reaction_id in(1,2,3,4))::numeric as total_count
                 from labmi.labmi_user_asset_reaction where reaction_id in(1,2,3,4)
                 group by reaction_id
                 )a
             )tab'
into v_user_response;

if v_user_response is not null then
		v_data := jsonb_set(v_data::jsonb,'{user_response}',v_user_response,true);
	end if;
    
    
with cte_data as ( select asset_id, asset_type_id,count(1) total from labmi.labmi_user_asset_reaction
                  where reaction_id is not null
              group by asset_id, asset_type_id
              order by total desc
              limit 10)
select '['||string_agg(row_to_json(tab)::text,',')||']' into v_popular_post
from (select  al.asset_title,
              case  al.asset_type_id  when 1 then 'article' when 2 then 'album' when 4 then 'video' else 'NA' end as post_type,
              (select count(1) from labmi.labmi_user_asset_reaction c where a.asset_id=c.asset_id and a.asset_type_id= c.asset_type_id and c.reaction_id=1)as "1",
              (select count(1) from labmi.labmi_user_asset_reaction c where a.asset_id=c.asset_id and a.asset_type_id= c.asset_type_id and c.reaction_id=2)as "2",
              (select count(1) from labmi.labmi_user_asset_reaction c where a.asset_id=c.asset_id and a.asset_type_id= c.asset_type_id and c.reaction_id=3)as "3",
              (select count(1) from labmi.labmi_user_asset_reaction c where a.asset_id=c.asset_id and a.asset_type_id= c.asset_type_id and c.reaction_id=4)as "4"
	from cte_data a
    left join labmi.labmi_asset_list al on a.asset_id=al.asset_id and a.asset_type_id= al.asset_type_id
     )tab;

if v_popular_post is not null then
		v_data := jsonb_set(v_data::jsonb,'{popular_post}',v_popular_post,true);
	end if;    
    

end if;
p_data:= v_data;

end;

$$;


--
