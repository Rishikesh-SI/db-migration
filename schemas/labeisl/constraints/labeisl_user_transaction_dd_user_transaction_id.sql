-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labeisl
-- Object: labeisl_user_transaction dd_user_transaction_id
-- Type: CONSTRAINT

-- Name: labeisl_user_transaction dd_user_transaction_id; Type: CONSTRAINT; Schema: labeisl; Owner: -
--

ALTER TABLE ONLY labeisl.labeisl_user_transaction
    ADD CONSTRAINT dd_user_transaction_id PRIMARY KEY (user_transaction_id);


--
