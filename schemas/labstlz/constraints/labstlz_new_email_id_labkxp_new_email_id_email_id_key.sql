-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstlz
-- Object: labstlz_new_email_id labkxp_new_email_id_email_id_key
-- Type: CONSTRAINT

-- Name: labstlz_new_email_id labkxp_new_email_id_email_id_key; Type: CONSTRAINT; Schema: labstlz; Owner: -
--

ALTER TABLE ONLY labstlz.labstlz_new_email_id
    ADD CONSTRAINT labkxp_new_email_id_email_id_key UNIQUE (email_id);


--
