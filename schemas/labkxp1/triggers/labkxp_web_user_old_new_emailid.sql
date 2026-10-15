-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxp1
-- Object: labkxp_web_user_old new_emailid
-- Type: TRIGGER

-- Name: labkxp_web_user_old new_emailid; Type: TRIGGER; Schema: labkxp1; Owner: -
--

CREATE TRIGGER new_emailid AFTER INSERT OR UPDATE ON labkxp1.labkxp_web_user_old FOR EACH ROW EXECUTE FUNCTION labkxp1.labkxp_ins_new_emailid();


--
