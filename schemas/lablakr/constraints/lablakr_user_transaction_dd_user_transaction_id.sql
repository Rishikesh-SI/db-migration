-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lablakr
-- Object: lablakr_user_transaction dd_user_transaction_id
-- Type: CONSTRAINT

-- Name: lablakr_user_transaction dd_user_transaction_id; Type: CONSTRAINT; Schema: lablakr; Owner: -
--

ALTER TABLE ONLY lablakr.lablakr_user_transaction
    ADD CONSTRAINT dd_user_transaction_id PRIMARY KEY (user_transaction_id);


--
