-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labecn_bkp05092024
-- Object: labecn_user_transaction dd_user_transaction_id
-- Type: CONSTRAINT

-- Name: labecn_user_transaction dd_user_transaction_id; Type: CONSTRAINT; Schema: labecn_bkp05092024; Owner: -
--

ALTER TABLE ONLY labecn_bkp05092024.labecn_user_transaction
    ADD CONSTRAINT dd_user_transaction_id PRIMARY KEY (user_transaction_id);


--
