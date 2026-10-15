-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgmr_01082024
-- Object: labgmr_user_transaction dd_user_transaction_id
-- Type: CONSTRAINT

-- Name: labgmr_user_transaction dd_user_transaction_id; Type: CONSTRAINT; Schema: labgmr_01082024; Owner: -
--

ALTER TABLE ONLY labgmr_01082024.labgmr_user_transaction
    ADD CONSTRAINT dd_user_transaction_id PRIMARY KEY (user_transaction_id);


--
