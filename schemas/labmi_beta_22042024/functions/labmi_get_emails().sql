-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_beta_22042024
-- Object: labmi_get_emails()
-- Type: FUNCTION

-- Name: labmi_get_emails(); Type: FUNCTION; Schema: labmi_beta_22042024; Owner: -
--

CREATE FUNCTION labmi_beta_22042024.labmi_get_emails(OUT p_user_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

declare
	
	
begin
 p_user_data := '{
  "data": [
    {
      "email_id": "ravi@sportzinteractive.net"
    },
    {
      "email_id": "abubakar@sportzinteractive.net"
    },
    {
      "email_id": "abhishek.kannan@sportzinteractive.net"
    },
    {
      "email_id": "dipnil@sportzinteractive.net"
    }
  ]
}';
	
end;

$$;


--
