-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_user_transaction labbsc_dev_user_transaction_pkey
-- Type: CONSTRAINT

-- Name: labbsc_dev_user_transaction labbsc_dev_user_transaction_pkey; Type: CONSTRAINT; Schema: labbsc_dev; Owner: -
--

ALTER TABLE ONLY labbsc_dev.labbsc_dev_user_transaction
    ADD CONSTRAINT labbsc_dev_user_transaction_pkey PRIMARY KEY (user_transaction_id);


--
