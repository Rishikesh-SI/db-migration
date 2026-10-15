-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labadkr
-- Object: labadkr_user_transaction dd_user_transaction_id
-- Type: CONSTRAINT

-- Name: labadkr_user_transaction dd_user_transaction_id; Type: CONSTRAINT; Schema: labadkr; Owner: -
--

ALTER TABLE ONLY labadkr.labadkr_user_transaction
    ADD CONSTRAINT dd_user_transaction_id PRIMARY KEY (user_transaction_id);


--
