-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdsg
-- Object: labdsg_web_user labdsg_web_user_client_id_social_id_key
-- Type: CONSTRAINT

-- Name: labdsg_web_user labdsg_web_user_client_id_social_id_key; Type: CONSTRAINT; Schema: labdsg; Owner: -
--

ALTER TABLE ONLY labdsg.labdsg_web_user
    ADD CONSTRAINT labdsg_web_user_client_id_social_id_key UNIQUE (client_id, social_id);


--
