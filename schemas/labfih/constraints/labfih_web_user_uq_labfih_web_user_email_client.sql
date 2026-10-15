-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labfih
-- Object: labfih_web_user uq_labfih_web_user_email_client
-- Type: CONSTRAINT

-- Name: labfih_web_user uq_labfih_web_user_email_client; Type: CONSTRAINT; Schema: labfih; Owner: -
--

ALTER TABLE ONLY labfih.labfih_web_user
    ADD CONSTRAINT uq_labfih_web_user_email_client UNIQUE (upper_email_id, client_id);


--
