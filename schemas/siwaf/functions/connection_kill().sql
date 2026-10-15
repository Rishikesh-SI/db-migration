-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: _connection_kill()
-- Type: FUNCTION

-- Name: _connection_kill(); Type: FUNCTION; Schema: siwaf; Owner: -
--

CREATE FUNCTION siwaf._connection_kill(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
	declare 
	 		
v_pid numeric;
	begin
	
	
	   SELECT pid, pg_terminate_backend(pid)
		FROM pg_stat_activity
		WHERE datname = 'siwafmasstg'
		AND pid <> pg_backend_pid()
		AND state in ('idle', 'idle in transaction', 'idle in transaction (aborted)', 'disabled')
		AND state_change < current_timestamp - INTERVAL '5' MINUTE
		into v_pid;

		p_result := 1;
			  

	end;
$$;


--
