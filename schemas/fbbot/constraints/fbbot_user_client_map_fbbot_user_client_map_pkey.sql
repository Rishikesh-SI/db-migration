-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: fbbot
-- Object: fbbot_user_client_map fbbot_user_client_map_pkey
-- Type: CONSTRAINT

-- Name: fbbot_user_client_map fbbot_user_client_map_pkey; Type: CONSTRAINT; Schema: fbbot; Owner: -
--

ALTER TABLE ONLY fbbot.fbbot_user_client_map
    ADD CONSTRAINT fbbot_user_client_map_pkey PRIMARY KEY (user_client_map_id);


--
