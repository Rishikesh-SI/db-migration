-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_ins_upd_play_photo_tag(numeric, numeric, character varying[], character varying[], numeric, character varying, numeric, numeric, numeric, numeric, numeric, numeric, refcursor, refcursor)
-- Type: FUNCTION

-- Name: zeven_ins_upd_play_photo_tag(numeric, numeric, character varying[], character varying[], numeric, character varying, numeric, numeric, numeric, numeric, numeric, numeric, refcursor, refcursor); Type: FUNCTION; Schema: zeven; Owner: -
--

CREATE FUNCTION zeven.zeven_ins_upd_play_photo_tag(p_opt_type numeric, p_pic_count numeric, p_arr_img_extension character varying[], p_arr_img_courtesy character varying[], p_photo_id numeric, p_image_guid character varying, p_play_activity_type_id numeric, p_play_activity_ref_id numeric, p_facility_id numeric, p_user_id numeric, p_zeven_published numeric, p_is_published numeric, p_ret refcursor, p_cur_auto_guid refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$

declare
--********************************preface block*******************************
--  name:   zeven.zvn_ins_upd_play_photo_tag
--
--  parameters:  
-- p_opt_type explaination:
-- 1 = generating guid for image name, parameters req: p_pic_count,p_play_activity_id,p_facility_id,p_user_id
-- 2 = saving images, parameters req: p_play_activity_id,p_facility_id,p_user_id,p_zeven_published
-- 3 = deleting images, parameters req: p_play_activity_id,p_facility_id,p_user_id
-- 4 = publishing images, parameters req: p_play_activity_id,p_facility_id,p_user_id
-- 
-- note: when tagging photos to facility, p_facility_id should be passed always
-- 
--  external output:  
--                    
--
--  written/modified:   date:           reason:
--  s.sarkar           20/11/2015      creation
--********************************end preface block***************************
v_photo_id numeric;
v_valid_user numeric;
v_valid_facility numeric;
v_sys_date timestamp(0);
v_arr_photo_id numeric[];
v_identifier_flag numeric;
v_sql text;
v_ret numeric;

begin

   v_sys_date := current_timestamp;
   v_photo_id := nextval('zeven.seq_zeven_photo_id');
   v_identifier_flag := nextval('zeven.seq_gtt_wafid'); 
   
      if p_opt_type = 1 then
      
      for i in 1..array_length(p_arr_img_extension,1) loop
         insert into zeven.zeven_pic_play_usr_act_map 
         (
          photo_id,image_name,play_activity_type_id,play_activity_ref_id,
          facility_id,user_id,is_saved,created_date,img_extension,img_courtesy
         )
         values(nextval('zeven.seq_zeven_photo_id'),uuid_generate_v4(),coalesce(p_play_activity_type_id,0),coalesce(p_play_activity_ref_id,0),
			coalesce(p_facility_id,0),
                 coalesce(p_user_id,0),0,v_sys_date,p_arr_img_extension[i],p_arr_img_courtesy[i]);
				 
				 v_arr_photo_id[i]:=currval('zeven.seq_zeven_photo_id');
				 
		end loop;
        
      for i in 1..array_length(v_arr_photo_id,1) loop
         insert into zeven.gtt_waf (col1_seqid,col2_number)
         values (v_identifier_flag,v_arr_photo_id[i]);
		end loop;
        
		
          v_ret := 1;
          
        else
          v_ret := -1;
                
        end if;
        
        open p_cur_auto_guid for
        select photo_id,image_name,img_extension
        from   zeven.zeven_pic_play_usr_act_map zppu
        where exists  (select col2_number
                                 from   zeven.gtt_waf gf
                                 where  gf.col2_number = zppu.photo_id
                                 and col1_seqid = v_identifier_flag);

         
     if p_opt_type = 2 then
          
         update zeven.zeven_pic_play_usr_act_map zppu
          set    is_saved           = 1,
                 is_deleted         = 0,
                 is_zeven_published =  p_zeven_published,
                 is_published       = p_is_published,
                 updated_date       = v_sys_date
          where image_name in (p_image_guid);
          
          
           v_ret := 2;
          
      end if;
    
      if p_opt_type = 3 then
          
          update zeven.zeven_pic_play_usr_act_map
          set    is_deleted = 1,
                 updated_date = v_sys_date
          where  image_name in( p_image_guid);
                
          
           v_ret := 3;
          
      end if;
      
      if p_opt_type = 4 then
          
          update zeven.zeven_pic_play_usr_act_map
          set    is_published = p_is_published,
                 updated_date = v_sys_date
          where  photo_id = p_photo_id;
                
          
           v_ret := 4;
          
      end if;
      open p_ret for select v_ret;
    
/*exception
when others then
  v_ret:=-2;
  open p_ret for select v_ret;*/
  
end;

$$;


--
