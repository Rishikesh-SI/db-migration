-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxp
-- Object: labkxp_new_email_id labkxp_new_email_id_email_id_key
-- Type: CONSTRAINT

-- Name: labkxp_new_email_id labkxp_new_email_id_email_id_key; Type: CONSTRAINT; Schema: labkxp; Owner: -
--

ALTER TABLE ONLY labkxp.labkxp_new_email_id
    ADD CONSTRAINT labkxp_new_email_id_email_id_key UNIQUE (email_id);


--
