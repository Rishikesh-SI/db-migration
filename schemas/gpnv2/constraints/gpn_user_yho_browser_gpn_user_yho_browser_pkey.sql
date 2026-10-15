-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpnv2
-- Object: gpn_user_yho_browser gpn_user_yho_browser_pkey
-- Type: CONSTRAINT

-- Name: gpn_user_yho_browser gpn_user_yho_browser_pkey; Type: CONSTRAINT; Schema: gpnv2; Owner: -
--

ALTER TABLE ONLY gpnv2.gpn_user_yho_browser
    ADD CONSTRAINT gpn_user_yho_browser_pkey PRIMARY KEY (user_id, application_id);


--
