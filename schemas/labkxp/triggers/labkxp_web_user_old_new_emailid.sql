-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxp
-- Object: labkxp_web_user_old new_emailid
-- Type: TRIGGER

-- Name: labkxp_web_user_old new_emailid; Type: TRIGGER; Schema: labkxp; Owner: -
--

CREATE TRIGGER new_emailid AFTER INSERT OR UPDATE ON labkxp.labkxp_web_user_old FOR EACH ROW EXECUTE FUNCTION labkxp.labkxp_ins_new_emailid();


--
