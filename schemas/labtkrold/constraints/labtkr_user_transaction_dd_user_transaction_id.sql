-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtkrold
-- Object: labtkr_user_transaction dd_user_transaction_id
-- Type: CONSTRAINT

-- Name: labtkr_user_transaction dd_user_transaction_id; Type: CONSTRAINT; Schema: labtkrold; Owner: -
--

ALTER TABLE ONLY labtkrold.labtkr_user_transaction
    ADD CONSTRAINT dd_user_transaction_id PRIMARY KEY (user_transaction_id);


--
