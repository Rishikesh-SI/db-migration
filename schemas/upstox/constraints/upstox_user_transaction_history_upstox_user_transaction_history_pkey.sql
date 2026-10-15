-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upstox
-- Object: upstox_user_transaction_history upstox_user_transaction_history_pkey
-- Type: CONSTRAINT

-- Name: upstox_user_transaction_history upstox_user_transaction_history_pkey; Type: CONSTRAINT; Schema: upstox; Owner: -
--

ALTER TABLE ONLY upstox.upstox_user_transaction_history
    ADD CONSTRAINT upstox_user_transaction_history_pkey PRIMARY KEY (user_transaction_history_id);


--
