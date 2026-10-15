-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labfih
-- Object: labfih_web_user labfih_web_user_email_id_key
-- Type: CONSTRAINT

-- Name: labfih_web_user labfih_web_user_email_id_key; Type: CONSTRAINT; Schema: labfih; Owner: -
--

ALTER TABLE ONLY labfih.labfih_web_user
    ADD CONSTRAINT labfih_web_user_email_id_key UNIQUE (email_id);


--
