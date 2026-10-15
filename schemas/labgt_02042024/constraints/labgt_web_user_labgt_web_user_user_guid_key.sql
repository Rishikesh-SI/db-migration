-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt_02042024
-- Object: labgt_web_user labgt_web_user_user_guid_key
-- Type: CONSTRAINT

-- Name: labgt_web_user labgt_web_user_user_guid_key; Type: CONSTRAINT; Schema: labgt_02042024; Owner: -
--

ALTER TABLE ONLY labgt_02042024.labgt_web_user
    ADD CONSTRAINT labgt_web_user_user_guid_key UNIQUE (user_guid);


--
