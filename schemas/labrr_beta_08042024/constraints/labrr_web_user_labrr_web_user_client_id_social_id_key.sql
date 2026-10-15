-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr_beta_08042024
-- Object: labrr_web_user labrr_web_user_client_id_social_id_key
-- Type: CONSTRAINT

-- Name: labrr_web_user labrr_web_user_client_id_social_id_key; Type: CONSTRAINT; Schema: labrr_beta_08042024; Owner: -
--

ALTER TABLE ONLY labrr_beta_08042024.labrr_web_user
    ADD CONSTRAINT labrr_web_user_client_id_social_id_key UNIQUE (client_id, social_id);


--
