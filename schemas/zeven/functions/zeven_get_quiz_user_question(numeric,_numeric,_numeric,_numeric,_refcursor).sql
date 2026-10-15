-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_get_quiz_user_question(numeric, numeric, numeric, numeric, refcursor)
-- Type: FUNCTION

-- Name: zeven_get_quiz_user_question(numeric, numeric, numeric, numeric, refcursor); Type: FUNCTION; Schema: zeven; Owner: -
--

CREATE FUNCTION zeven.zeven_get_quiz_user_question(p_userid numeric, p_quizid numeric, p_prevquestionid numeric, p_useranswer numeric, p_question_cur refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$

declare
	
    v_currentdate timestamp := current_timestamp at time zone 'utc';
	v_quizid numeric;
    v_correctanswer numeric;
    v_isuseranswercorrect numeric;
    v_prevquestiontime timestamp;
    v_timeleft numeric;
    v_totalpoints numeric := 0;
    v_nextquestionid numeric;
    
begin
	
    /*update zeven.zeven_quiz_question_master
    set quiz_status = 1
    where date(quiz_date) <> date(v_currentdate);*/
    
    select distinct quiz_id
    into strict v_quizid
    from zeven.zeven_quiz_question_master
    where /*date(quiz_date) = date(v_currentdate)
    and*/ quiz_status = 0;
    
    if not exists(select 1 from zeven.zeven_quiz_user_map where quiz_id = v_quizid and user_id = p_userid) then
    	
        insert into zeven.zeven_quiz_user_map
        select nextval('zeven.seq_zeven_qum_id'),v_quizid,p_userid,question_id,null,null,null,null,null,0,v_currentdate,v_currentdate,
        		row_number() over(order by random())
        from zeven.zeven_quiz_question_master
        where quiz_id = v_quizid
        order by random()
        limit 5;
	
    else
    	
        select correct_answer
        into v_correctanswer
        from zeven.zeven_quiz_question_master
        where quiz_id = v_quizid
        and question_id = p_prevquestionid;
        
        select question_time
    	into v_prevquestiontime
    	from zeven.zeven_quiz_user_map
    	where quiz_id = v_quizid
    	and user_id = p_userid
    	and is_answered = 0
        and question_id = p_prevquestionid;
        
        if v_correctanswer = p_useranswer then
        	v_isuseranswercorrect := 1;
		else
        	v_isuseranswercorrect := 0;
        end if;
        
        v_timeleft := round(extract('seconds' from v_currentdate - v_prevquestiontime))::numeric;
        
        update zeven.zeven_quiz_user_map
        set user_answer = p_useranswer,
        	answer_time = v_currentdate,
            points = case v_isuseranswercorrect when 1 then case when v_timeleft <= 15 then 30 else 20 end else 0 end,
            is_answered = 1
        where quiz_id = v_quizid
        and user_id = p_userid
        and question_id = p_prevquestionid;
    
    end if;
    
    select question_id
    into v_nextquestionid
    from zeven.zeven_quiz_user_map
    where quiz_id = v_quizid
    and user_id = p_userid
    and is_answered = 0
    order by question_srno
    limit 1;
    
    update zeven.zeven_quiz_user_map
    set question_time = case coalesce(p_prevquestionid,0) when 0 then v_currentdate else v_currentdate + ('2 seconds')::interval end
    where quiz_id = v_quizid
    and user_id = p_userid
    and is_answered = 0
    and question_id = v_nextquestionid;
    
    select sum(points)
    into v_totalpoints
    from zeven.zeven_quiz_user_map
    where quiz_id = v_quizid
    and user_id = p_userid
    and is_answered = 1;
    
    if v_nextquestionid is not null then
    	
        open p_question_cur for
    	select qqm.quiz_id,qum.question_srno,qqm.question_id,qqm.question_text,qqm.answer_a,qqm.answer_b,qqm.answer_c,qqm.answer_d,
        		v_isuseranswercorrect isuseranswercorrect,v_totalpoints points
		from zeven.zeven_quiz_user_map qum
		join zeven.zeven_quiz_question_master qqm
		on qqm.quiz_id = qum.quiz_id
		and qqm.question_id = qum.question_id
		where qum.quiz_id = v_quizid
		and qum.user_id = p_userid
		and qum.is_answered = 0
		and qum.question_id = v_nextquestionid;
        
	else
    	
        open p_question_cur for
    	select null quiz_id,null question_srno,null question_id,null question_text,null answer_a,null answer_b,null answer_c,null answer_d,
        		v_isuseranswercorrect isuseranswercorrect,v_totalpoints points;
        
    end if;
	
exception
	when no_data_found then
    	open p_question_cur for
    	select null quiz_id,null question_srno,null question_id,null question_text,null answer_a,null answer_b,null answer_c,null answer_d,
        		null isuseranswercorrect,null points;
		
end;

$$;


--
