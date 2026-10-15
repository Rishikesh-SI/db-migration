-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrao
-- Object: labrao_user_activity_master labrao_user_activity_master_pkey
-- Type: CONSTRAINT

-- Name: labrao_user_activity_master labrao_user_activity_master_pkey; Type: CONSTRAINT; Schema: labrao; Owner: -
--

ALTER TABLE ONLY labrao.labrao_user_activity_master
    ADD CONSTRAINT labrao_user_activity_master_pkey PRIMARY KEY (user_activity_id);


--
