-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labadkr_beta
-- Object: labadkr_user_transaction dd_user_transaction_id
-- Type: CONSTRAINT

-- Name: labadkr_user_transaction dd_user_transaction_id; Type: CONSTRAINT; Schema: labadkr_beta; Owner: -
--

ALTER TABLE ONLY labadkr_beta.labadkr_user_transaction
    ADD CONSTRAINT dd_user_transaction_id PRIMARY KEY (user_transaction_id);


--
