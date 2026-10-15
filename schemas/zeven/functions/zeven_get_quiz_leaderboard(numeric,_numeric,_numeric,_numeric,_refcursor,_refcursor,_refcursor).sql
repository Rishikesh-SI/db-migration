-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_get_quiz_leaderboard(numeric, numeric, numeric, numeric, refcursor, refcursor, refcursor)
-- Type: FUNCTION

-- Name: zeven_get_quiz_leaderboard(numeric, numeric, numeric, numeric, refcursor, refcursor, refcursor); Type: FUNCTION; Schema: zeven; Owner: -
--

CREATE FUNCTION zeven.zeven_get_quiz_leaderboard(p_userid numeric, p_pagenumber numeric, p_itemnumber numeric, p_page1size numeric, p_count_cur refcursor, p_leaderboard_cur refcursor, p_userleaderboard_cur refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$

declare
	
	v_quizid numeric;
    v_fromrownumber numeric;
    v_torownumber numeric;
    
begin
	
    if p_page1size is null then
        v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
        v_torownumber := p_pagenumber * p_itemnumber;
	else
        if p_pagenumber = 1 then
            v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
		else
        	v_fromrownumber := p_page1size + ( (( (p_pagenumber-1) * p_itemnumber) - (p_itemnumber - 1)));
		end if;
        v_torownumber := p_page1size + ( (p_pagenumber-1) * p_itemnumber);
	end if;
    
    begin
    	select distinct quiz_id
    	into strict v_quizid
    	from zeven.zeven_quiz_question_master
    	where quiz_status = 0;
    exception
    	when no_data_found then
        	select distinct quiz_id
    		into v_quizid
    		from zeven.zeven_quiz_question_master
    		where quiz_date = (select max(quiz_date) from zeven.zeven_quiz_question_master);
    end;
    
    open p_count_cur for
    select count(1) totalcount
    from
    (
        select quiz_id,user_id
        from zeven.zeven_quiz_user_map
        where quiz_id = v_quizid
        and is_answered = 1
        group by quiz_id,user_id
        having sum(points) > 0
    )a;
    
    open p_leaderboard_cur for
    select quiz_id,social_user_name,totalpoints,rank,slno
    from
    (
        select quiz_id,social_user_name,totalpoints,rank,row_number() over(order by rank) slno
    	from
    	(
            select quiz_id,case client_id when 5 then user_full_name else social_user_name end social_user_name,totalpoints,
            		rank() over(order by totalpoints desc,totalseconds)::numeric rank
    		from
            (
                select quiz_id,user_id,sum(points) totalpoints,sum(round(extract('seconds' from answer_time - question_time))::numeric) totalseconds
            	from zeven.zeven_quiz_user_map
            	where quiz_id = v_quizid
            	and is_answered = 1
            	group by quiz_id,user_id
                having sum(points) > 0
        	) a
            join zeven.zeven_web_user wu
            on wu.user_id = a.user_id
    	)b
    )c
    where slno between v_fromrownumber and v_torownumber;
    
    open p_userleaderboard_cur for
    select quiz_id,social_user_name,totalpoints,rank,1 slno
    from
    (
    	select quiz_id,a.user_id,case client_id when 5 then user_full_name else social_user_name end social_user_name,totalpoints,
        		rank() over(order by totalpoints desc,totalseconds)::numeric rank
        from
        (
            select quiz_id,user_id,sum(points) totalpoints,sum(round(extract('seconds' from answer_time - question_time))::numeric) totalseconds
    		from zeven.zeven_quiz_user_map
    		where quiz_id = v_quizid
    		and is_answered = 1
    		group by quiz_id,user_id
            having sum(points) > 0
		)a
        join zeven.zeven_web_user wu
        on wu.user_id = a.user_id
	) b
    where user_id = p_userid;
    
end;

$$;


--
