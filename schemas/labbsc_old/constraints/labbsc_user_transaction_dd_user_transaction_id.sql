-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_old
-- Object: labbsc_user_transaction dd_user_transaction_id
-- Type: CONSTRAINT

-- Name: labbsc_user_transaction dd_user_transaction_id; Type: CONSTRAINT; Schema: labbsc_old; Owner: -
--

ALTER TABLE ONLY labbsc_old.labbsc_user_transaction
    ADD CONSTRAINT dd_user_transaction_id PRIMARY KEY (user_transaction_id);


--
