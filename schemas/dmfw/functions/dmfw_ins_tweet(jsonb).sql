-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dmfw
-- Object: dmfw_ins_tweet(jsonb)
-- Type: FUNCTION

-- Name: dmfw_ins_tweet(jsonb); Type: FUNCTION; Schema: dmfw; Owner: -
--

CREATE FUNCTION dmfw.dmfw_ins_tweet(p_json jsonb, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

declare
	
	v_json jsonb :=  p_json;
	v_social_id text;
	v_followers numeric;
	v_tweet_unique_id text;
	v_tweet text;
	v_rt_count numeric;
	v_likes_count numeric;
	v_replies_count numeric;
	v_teams text;
	v_user_id numeric;
	v_tweet_id numeric;
	v_teams_arr numeric[];
	v_current_timestamp timestamp := current_timestamp at time zone 'utc';
	v_tweet_type text;
	
begin
	
	select v_json->>'social_id',
			v_json->>'followers',
			v_json->>'tweet_id',
			v_json->>'tweet',
			v_json->>'rt_count',
			v_json->>'likes_count',
			v_json->>'replies_count',
			v_json->>'teams',
			v_json->>'kind'
	into v_social_id,
			v_followers,
			v_tweet_unique_id,
			v_tweet,
			v_rt_count,
			v_likes_count,
			v_replies_count,
			v_teams,
			v_tweet_type;
	
	if not exists (select 1 from dmfw.dmfw_twitter_users tu join dmfw.dmfw_user_tweets ut on ut.user_id = tu.user_id
					where tu.social_id = v_social_id and ut.tweet_unique_id = v_tweet_unique_id) then
		
		if not exists(select 1 from dmfw.dmfw_twitter_users where social_id = v_social_id) then
			
			v_user_id := nextval('dmfw.seq_dmfw_user_id');
			insert into dmfw.dmfw_twitter_users(user_id,social_id,followers_count,ipl_fan_score,created_date)
			select v_user_id,v_social_id,v_followers,null,v_current_timestamp;
			
		else
			
			select user_id into v_user_id from dmfw.dmfw_twitter_users where social_id = v_social_id;
			
		end if;
		
		v_tweet_id := nextval('dmfw.seq_dmfw_tweet_id');
		
		insert into dmfw.dmfw_user_tweets(tweet_id,user_id,tweet_unique_id,tweet,re_tweet_count,likes_count,replies_count,points,created_date,tweet_type)
		select v_tweet_id,v_user_id,v_tweet_unique_id,v_tweet,v_rt_count,v_likes_count,v_replies_count,null,v_current_timestamp,v_tweet_type;
		
		select ('{'||replace(v_teams,',',',')||'}')::numeric[] into v_teams_arr;
		
		insert into dmfw.dmfw_user_tweets_team_map(user_tweets_team_map_id,tweet_id,team_id,created_date)
		select nextval('dmfw.seq_dmfw_user_tweets_team_map_id'),v_tweet_id,unnest(v_teams_arr),v_current_timestamp;
		
		p_result := 1;
		
	else
		
		p_result := 0;
		
	end if;
	
exception
	when others then
		p_result := -1;
		
end;

$$;


--
