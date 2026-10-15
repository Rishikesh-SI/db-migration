-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tsk
-- Object: tsk_user_master tsk_user_master_pkey
-- Type: CONSTRAINT

-- Name: tsk_user_master tsk_user_master_pkey; Type: CONSTRAINT; Schema: tsk; Owner: -
--

ALTER TABLE ONLY tsk.tsk_user_master
    ADD CONSTRAINT tsk_user_master_pkey PRIMARY KEY (user_id);


--
