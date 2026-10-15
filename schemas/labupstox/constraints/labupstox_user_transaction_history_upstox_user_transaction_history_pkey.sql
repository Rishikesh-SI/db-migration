-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labupstox
-- Object: labupstox_user_transaction_history upstox_user_transaction_history_pkey
-- Type: CONSTRAINT

-- Name: labupstox_user_transaction_history upstox_user_transaction_history_pkey; Type: CONSTRAINT; Schema: labupstox; Owner: -
--

ALTER TABLE ONLY labupstox.labupstox_user_transaction_history
    ADD CONSTRAINT upstox_user_transaction_history_pkey PRIMARY KEY (user_transaction_history_id);


--
