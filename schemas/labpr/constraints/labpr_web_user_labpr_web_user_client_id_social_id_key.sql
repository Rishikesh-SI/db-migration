-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpr
-- Object: labpr_web_user labpr_web_user_client_id_social_id_key
-- Type: CONSTRAINT

-- Name: labpr_web_user labpr_web_user_client_id_social_id_key; Type: CONSTRAINT; Schema: labpr; Owner: -
--

ALTER TABLE ONLY labpr.labpr_web_user
    ADD CONSTRAINT labpr_web_user_client_id_social_id_key UNIQUE (client_id, social_id);


--
