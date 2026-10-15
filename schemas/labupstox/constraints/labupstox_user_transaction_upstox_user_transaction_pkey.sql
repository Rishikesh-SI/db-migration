-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labupstox
-- Object: labupstox_user_transaction upstox_user_transaction_pkey
-- Type: CONSTRAINT

-- Name: labupstox_user_transaction upstox_user_transaction_pkey; Type: CONSTRAINT; Schema: labupstox; Owner: -
--

ALTER TABLE ONLY labupstox.labupstox_user_transaction
    ADD CONSTRAINT upstox_user_transaction_pkey PRIMARY KEY (user_transaction_id);


--
