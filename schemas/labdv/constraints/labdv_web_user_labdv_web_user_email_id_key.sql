-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdv
-- Object: labdv_web_user labdv_web_user_email_id_key
-- Type: CONSTRAINT

-- Name: labdv_web_user labdv_web_user_email_id_key; Type: CONSTRAINT; Schema: labdv; Owner: -
--

ALTER TABLE ONLY labdv.labdv_web_user
    ADD CONSTRAINT labdv_web_user_email_id_key UNIQUE (email_id);


--
