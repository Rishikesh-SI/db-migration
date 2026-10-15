-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgrl
-- Object: labgrl_user_transaction dd_user_transaction_id
-- Type: CONSTRAINT

-- Name: labgrl_user_transaction dd_user_transaction_id; Type: CONSTRAINT; Schema: labgrl; Owner: -
--

ALTER TABLE ONLY labgrl.labgrl_user_transaction
    ADD CONSTRAINT dd_user_transaction_id PRIMARY KEY (user_transaction_id);


--
