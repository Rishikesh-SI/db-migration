-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrs_2602
-- Object: labrs_user_transaction dd_user_transaction_id
-- Type: CONSTRAINT

-- Name: labrs_user_transaction dd_user_transaction_id; Type: CONSTRAINT; Schema: labrs_2602; Owner: -
--

ALTER TABLE ONLY labrs_2602.labrs_user_transaction
    ADD CONSTRAINT dd_user_transaction_id PRIMARY KEY (user_transaction_id);


--
