-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkkr
-- Object: labkkr_user_transaction dd_user_transaction_id
-- Type: CONSTRAINT

-- Name: labkkr_user_transaction dd_user_transaction_id; Type: CONSTRAINT; Schema: labkkr; Owner: -
--

ALTER TABLE ONLY labkkr.labkkr_user_transaction
    ADD CONSTRAINT dd_user_transaction_id PRIMARY KEY (user_transaction_id);


--
