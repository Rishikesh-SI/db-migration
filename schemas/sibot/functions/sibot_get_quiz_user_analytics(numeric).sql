-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: sibot
-- Object: sibot_get_quiz_user_analytics(numeric)
-- Type: FUNCTION

-- Name: sibot_get_quiz_user_analytics(numeric); Type: FUNCTION; Schema: sibot; Owner: -
--

CREATE FUNCTION sibot.sibot_get_quiz_user_analytics(p_application_id numeric, OUT p_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

declare
	v_unique_user_count numeric;
	v_non_unique_user_count numeric;
	v_catgeory_unique_user_count_json jsonb;
    v_catgeory_non_unique_user_count_json jsonb;
	v_category_wise_quiz_question_count jsonb;
	v_overall_quiz_question_count numeric;
	v_quiz_question_wise_count jsonb;
	v_catgeory_unique_and_non_unique_user_count_json jsonb;
	
begin

		select sum(b.user_count)  into v_unique_user_count from 
		      (select a.quiz_id,a.quiz_title,count(a.user_id) user_count from 
			         (select  distinct user_id,q.quiz_id,quiz_title
		              from sibot.sibot_user_quiz_play uq
		              join sibot.sibot_application_quiz q
		              on uq.quiz_id=q.quiz_id
					  where application_id=p_application_id
		              group by q.quiz_id,quiz_title,user_id)a 
			   group by a.quiz_id,a.quiz_title)b;
 
		select sum(a.user_count) into v_non_unique_user_count from 
		       (select distinct q.quiz_id,quiz_title,count(1) as user_count 
				from sibot.sibot_user_quiz_play uq
		        join sibot.sibot_application_quiz q
		        on uq.quiz_id=q.quiz_id
				where application_id=p_application_id
		        group by q.quiz_id,quiz_title)a;
				
		select ('['||string_agg(row_to_json(row)::text,',')||']')::jsonb
	      from (select a.quiz_id,a.quiz_title,count(a.user_id) unique_user_count ,sum(a.non_unique_user_count) non_unique_user_count 
				from (select  distinct user_id,q.quiz_id,quiz_title,ceil (count(1)/5) + case when ceil(count(1)%5)=0 then 0 else 1 end as non_unique_user_count
                      from sibot.sibot_user_quiz_play uq
                      join sibot.sibot_application_quiz q
                      on uq.quiz_id=q.quiz_id
				      where application_id=1
                      group by q.quiz_id,quiz_title,user_id
					 )a 
		        group by a.quiz_id,a.quiz_title
				) row
		into v_catgeory_unique_and_non_unique_user_count_json;

	  
	/*select ('['||string_agg(row_to_json(row)::text,',')||']')::jsonb
	from (select a.quiz_id,a.quiz_title,count(a.user_id) user_count from 
		         (select  distinct user_id,q.quiz_id,quiz_title
                    from sibot.sibot_user_quiz_play uq
                    join sibot.sibot_application_quiz q
                    on uq.quiz_id=q.quiz_id
				    where application_id=p_application_id
                    group by q.quiz_id,quiz_title,user_id)a 
		  group by a.quiz_id,a.quiz_title
		 )row
	into v_catgeory_unique_user_count_json;
    select ('['||string_agg(row_to_json(row)::text,',')||']')::jsonb
	from (select distinct q.quiz_id,quiz_title,ceil (count(1)/5) + case when ceil(count(1)%5)=0 then 0 else 1 end user_count
          from sibot.sibot_user_quiz_play uq
          join sibot.sibot_application_quiz q
          on uq.quiz_id=q.quiz_id
		  where application_id=p_application_id
          group by q.quiz_id,quiz_title
         )row
	into v_catgeory_non_unique_user_count_json;*/
	
	select ('['||string_agg(row_to_json(row)::text,',')||']')::jsonb
	 from (select aq.quiz_id,aq.quiz_title , sum(is_answered) as question_answered_count
		    from sibot.sibot_user_quiz_play uqp
            join sibot.sibot_application_quiz aq
            on uqp.quiz_id=aq.quiz_id
		    where application_id=p_application_id
            group by aq.quiz_id,aq.quiz_title
		  ) row 
    into v_category_wise_quiz_question_count;




    select sum(a.sum)  into v_overall_quiz_question_count 
	 from (select aq.quiz_id,aq.quiz_title,sum(is_answered) as sum 
           from sibot.sibot_user_quiz_play uqp
           join sibot.sibot_application_quiz aq
           on uqp.quiz_id=aq.quiz_id
           where application_id=p_application_id
           group by aq.quiz_id,aq.quiz_title
		  )a;

   select ('['||string_agg(row_to_json(row)::text,',')||']')::jsonb
	from (select aq.quiz_id,aq.quiz_title ,qq.question_text ,sum(is_answered) as question_answered_count
		  from sibot.sibot_user_quiz_play uqp
          join sibot.sibot_application_quiz aq
          on uqp.quiz_id=aq.quiz_id
          join sibot.sibot_quiz_question qq
          on uqp.question_id=qq.question_id
		  where application_id=p_application_id
          group by aq.quiz_id,aq.quiz_title,qq.question_text
          order by quiz_id
	      )row 
    into v_quiz_question_wise_count;
    
	select row_to_json(row)::jsonb
	from (select v_unique_user_count,v_non_unique_user_count,v_catgeory_unique_and_non_unique_user_count_json,
		 v_category_wise_quiz_question_count,v_overall_quiz_question_count,v_quiz_question_wise_count)row
	into p_json;
end;

$$;


--
