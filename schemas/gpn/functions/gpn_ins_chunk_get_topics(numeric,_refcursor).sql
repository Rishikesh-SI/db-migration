-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpn
-- Object: gpn_ins_chunk_get_topics(numeric, refcursor)
-- Type: FUNCTION

-- Name: gpn_ins_chunk_get_topics(numeric, refcursor); Type: FUNCTION; Schema: gpn; Owner: -
--

CREATE FUNCTION gpn.gpn_ins_chunk_get_topics(p_client_id numeric, p_topic_chunk_detail refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$

declare
	
    v_chunk_size numeric;
    v_maximum_parallel_chunk numeric;
    v_topic_id numeric;
    v_in_progress_count numeric;
    v_pending_count numeric;
    v_required_count numeric;
    v_user_count numeric;
    v_chunk_start_value numeric;
    v_chunk_end_value numeric;
    v_chunk_count numeric;
    v_current_timestamp timestamp := current_timestamp;
    
begin
	
    select chunk_size, maximum_parallel_chunk
    into   v_chunk_size, v_maximum_parallel_chunk
    from   gpn.gpn_client
    where  client_id = coalesce(p_client_id, 0);
    
    if exists(select 1 from gpn.gpn_topic_chunk_map where status = 0) then
    	
        select topic_id
        into   v_topic_id
        from   gpn.gpn_topic_chunk_map
        where  status = 0
        limit 1;
        
        select count(1)
        into   v_in_progress_count
        from   gpn.gpn_topic_chunk_map
        where  topic_id = v_topic_id
        and    status = 1;
        
        select count(1)
        into   v_pending_count
        from   gpn.gpn_topic_chunk_map
        where  topic_id = v_topic_id
        and    status = 0;
        
        v_required_count := least((v_maximum_parallel_chunk - v_in_progress_count), v_pending_count);
        
	else
        
        delete 
        from   gpn.gpn_user_topic_change utc
        where  exists(select 1
                      from   gpn.gpn_user_topic_map utm
                      where  utm.user_id  = utc.user_id
                      and    utm.topic_id  = utc.topic_id
                      and    status      = 4)
        and    option = 2; 
        
        update gpn.gpn_user_topic_map
        set    status = 1, updated_date = v_current_timestamp
        where  status = 4;
        
        select t.topic_id
        into v_topic_id
        from   gpn.gpn_topic t
        join   gpn.gpn_match m
    	on     (m.match_id = t.match_id
                or m.source_object_id = t.match_id::varchar)
    	join   gpn.gpn_client_application_map cam
    	on     cam.application_id = t.application_id
    	where  cam.client_id = coalesce(p_client_id, cam.client_id)
    	and    ((-- t.status = 0
                  t.status = 1
                 and 
                 t.topic_arn <> 'na')
                and exists(select 1
                          from   gpn.gpn_user_topic_map utm
                          where  utm.topic_id = t.topic_id
                          and    utm.status = 0
                          and    utm.subscription_arn is null)
                )
    	order by t.topic_id,m.match_start_date
    	limit 1;
        
        if v_topic_id is not null then
        	
            update gpn.gpn_user_topic_map
        	set    status = 4, updated_date = v_current_timestamp
        	where  status = 0
        	and    topic_id = v_topic_id;
        	
        	select count(1)
        	into   v_user_count
        	from   gpn.gpn_user_topic_map
        	where  topic_id = v_topic_id
        	and    status = 4;
        	
        	v_chunk_start_value := 1;
        	
        	if v_user_count <= v_chunk_size then
        		v_chunk_end_value := v_user_count;
          else
        		v_chunk_end_value := v_chunk_size;
        	end if;
        	
        	v_chunk_count := div(v_user_count,v_chunk_size);
        	
        	if (v_chunk_count = 0 or (v_user_count - (v_chunk_count * v_chunk_size)) > 0) then
        		v_chunk_count := v_chunk_count + 1;
        	end if;
        	
        	for i in 1..v_chunk_count
        	loop
            	
            	insert into gpn.gpn_topic_chunk_map
            	select nextval('gpn.seq_gpn_topic_chunck_map_id'), v_topic_id, i, v_chunk_start_value, v_chunk_end_value, 0, v_current_timestamp,
                	   v_current_timestamp, 1, 0;
				
            	v_chunk_start_value := v_chunk_end_value + 1;
            	
            	if (v_user_count - v_chunk_end_value) >= v_chunk_size then
            		v_chunk_end_value := (v_chunk_start_value + v_chunk_size) - 1;
              else
            		v_chunk_end_value := v_user_count;
            	end if;
            	
        	end loop;
        	
        	v_required_count := v_maximum_parallel_chunk;
            
        end if;
        
    end if;
    
    perform 1;
    
    open p_topic_chunk_detail for
    select slno, topic_id, chunk_id
    from
    (
   		select row_number() over(order by chunk_id) slno, topic_id, chunk_id
    	from   gpn.gpn_topic_chunk_map
    	where  topic_id = v_topic_id
    	and    status = 0
	)a
    where slno <= v_required_count;
    
end;

$$;


--
