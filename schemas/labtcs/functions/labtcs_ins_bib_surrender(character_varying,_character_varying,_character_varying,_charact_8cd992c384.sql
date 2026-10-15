-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtcs
-- Object: labtcs_ins_bib_surrender(character varying, character varying, character varying, character varying, numeric, numeric, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, numeric, character varying, character varying, character varying, character varying)
-- Type: FUNCTION

-- Name: labtcs_ins_bib_surrender(character varying, character varying, character varying, character varying, numeric, numeric, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, numeric, character varying, character varying, character varying, character varying); Type: FUNCTION; Schema: labtcs; Owner: -
--

CREATE FUNCTION labtcs.labtcs_ins_bib_surrender(p_applicant_first_name character varying, p_applicant_last_name character varying, p_applicant_dob character varying, p_applicant_gender character varying, p_applicant_app_id numeric, p_applicant_bib_no numeric, p_applicant_race_category character varying, p_reason character varying, p_is_nominating character varying, p_nominee_first_name character varying, p_nominee_last_name character varying, p_nominee_dob character varying, p_nominee_gender character varying, p_timing_certificate_link character varying, p_timing_certificate_event_name character varying, p_timing_certificate_race_category character varying, p_timing_certificate_bib_number numeric, p_nominee_email_id character varying, p_nominee_contact_number character varying, p_nominee_address character varying, p_nominee_nationality character varying, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

declare
	
    v_continue numeric;
    
begin
	if exists(select 1
              from labtcs.labtcs_app_status
              where app_id = p_applicant_app_id
              and bib_no::numeric = p_applicant_bib_no
              and left(date_of_birth::varchar,10) = p_applicant_dob
              and lower(race) = lower(p_applicant_race_category)
              and lower(status) = 'accepted') then
		
		insert into labtcs.labtcs_bib_surrender(bib_surrender_id, app_id, first_name, last_name, date_of_birth, gender, race, surrender_reason, bib_no,
                                          is_nominating, created_date, updated_date, is_active, is_deleted)
        values(nextval('labtcs.seq_labtcs_bib_surrender_id'), p_applicant_app_id, p_applicant_first_name, p_applicant_last_name, p_applicant_dob,
               p_applicant_gender, p_applicant_race_category, p_reason, p_applicant_bib_no, p_is_nominating, current_timestamp at time zone 'utc',
               current_timestamp at time zone 'utc', 1, 0);
		
        p_result := currval('labtcs.seq_labtcs_bib_surrender_id');
        
        if lower(p_is_nominating) = 'yes' or lower(p_is_nominating) = 'y' then
        	
            if ((lower(p_applicant_race_category) = 'marathon' and lower(p_timing_certificate_race_category) <> 'timed 10k')
            	or lower(p_applicant_race_category) <> 'marathon') then
            	
                if lower(p_applicant_race_category) in('marathon', 'half marathon') and p_nominee_dob <= '2000-01-20' then
                	v_continue := 1;
				elsif lower(p_applicant_race_category) = 'timed 10k' and p_nominee_dob <= '2003-01-21' then
                	v_continue := 1;
				else
                	v_continue := 0;
                end if;
                
                if v_continue = 1 then
                	
                    insert into labtcs.labtcs_bib_nomination(bib_nomination_id, first_name, last_name, date_of_birth, gender, tc_link, tc_event_name, 
                                                       tc_race, tc_bib_no, email_id, contact_number, address, nationality, created_date, updated_date, 
                                                       is_active, is_deleted, bib_surrender_id)
            		values(nextval('labtcs.seq_labtcs_bib_nomination_id'), p_nominee_first_name, p_nominee_last_name, p_nominee_dob, p_nominee_gender, 
                           p_timing_certificate_link, p_timing_certificate_event_name, p_timing_certificate_race_category, 
                           p_timing_certificate_bib_number, p_nominee_email_id, p_nominee_contact_number, p_nominee_address, p_nominee_nationality, 
                           current_timestamp at time zone 'utc', current_timestamp at time zone 'utc', 1, 0, currval('labtcs.seq_labtcs_bib_surrender_id'));
					
                    p_result := currval('labtcs.seq_labtcs_bib_surrender_id');
                    
				else
                	
                    p_result := -2;
                    
                    delete from labtcs.labtcs_bib_surrender where bib_surrender_id = currval('labtcs.seq_labtcs_bib_surrender_id');
                    
                end if;
				
			else
            	
                p_result := -1;
                
                delete from labtcs.labtcs_bib_surrender where bib_surrender_id = currval('labtcs.seq_labtcs_bib_surrender_id');
                
            end if;
            
        end if;
        
        -- p_result := currval('labtcs.seq_labtcs_bib_surrender_id');
        
	else
    	
        p_result := 0;
        
	end if;
    
end;

$$;


--
