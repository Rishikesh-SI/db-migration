-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgfg
-- Object: labgfg_user_transaction dd_user_transaction_id
-- Type: CONSTRAINT

-- Name: labgfg_user_transaction dd_user_transaction_id; Type: CONSTRAINT; Schema: labgfg; Owner: -
--

ALTER TABLE ONLY labgfg.labgfg_user_transaction
    ADD CONSTRAINT dd_user_transaction_id PRIMARY KEY (user_transaction_id);


--
