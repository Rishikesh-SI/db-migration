-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_web_user labbsc_dev_web_user_email_id_key
-- Type: CONSTRAINT

-- Name: labbsc_dev_web_user labbsc_dev_web_user_email_id_key; Type: CONSTRAINT; Schema: labbsc_dev; Owner: -
--

ALTER TABLE ONLY labbsc_dev.labbsc_dev_web_user
    ADD CONSTRAINT labbsc_dev_web_user_email_id_key UNIQUE (email_id);


--
