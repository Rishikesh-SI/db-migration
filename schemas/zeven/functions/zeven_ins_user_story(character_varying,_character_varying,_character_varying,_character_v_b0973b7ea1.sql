-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_ins_user_story(character varying, character varying, character varying, character varying, character varying, timestamp without time zone, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, refcursor, refcursor)
-- Type: FUNCTION

-- Name: zeven_ins_user_story(character varying, character varying, character varying, character varying, character varying, timestamp without time zone, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, refcursor, refcursor); Type: FUNCTION; Schema: zeven; Owner: -
--

CREATE FUNCTION zeven.zeven_ins_user_story(p_first_name character varying, p_last_name character varying, p_phone_no character varying, p_email_id character varying, p_city character varying, p_dob timestamp without time zone, p_sports_played character varying, p_twitter_id character varying, p_facebook_id character varying, p_google_id character varying, p_photos character varying, p_videos character varying, p_achivements character varying, p_story character varying, p_user_story refcursor, p_return refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$

declare 
  v_exists numeric;
  v_return numeric;

begin

  select count(1)
  into v_exists
  from zeven.zeven_user_story
  where upper(email_id) = upper(p_email_id);
  if v_exists = 0 then
    insert into zeven.zeven_user_story(zeven_user_story_id,
                                       first_name,
                                       last_name,
                                       phone_no,
                                       email_id,
                                       city,
                                       dob,
                                       sports_played,
                                       twitter_id,
                                       facebook_id,
                                       google_id,
                                       photos,
                                       videos,
                                       achivements,
                                       story
                                      )
    values(nextval('zeven.seq_zeven_user_story_id'),
           p_first_name,
           p_last_name,
           p_phone_no,
           p_email_id,
           p_city,
           p_dob,
           p_sports_played,
           p_twitter_id,
           p_facebook_id,
           p_google_id,
           p_photos,
           p_videos,
           p_achivements,
           p_story
          );
    v_return := 1;
  else
    v_return := 0;
  end if;
  open p_user_story for
  select zeven_user_story_id,
         first_name,
         last_name,
         phone_no,
         email_id,
         city,
         dob,
         sports_played,
         twitter_id,
         facebook_id,
         google_id,
         photos,
         videos,
         achivements,
         story
  from zeven.zeven_user_story;
  
  open p_return for select v_return as p_return;
  
exception
  when others then
    open p_return for select -1 as p_return;
end;

$$;


--
