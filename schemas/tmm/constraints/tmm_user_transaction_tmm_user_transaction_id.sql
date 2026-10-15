-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmm
-- Object: tmm_user_transaction tmm_user_transaction_id
-- Type: CONSTRAINT

-- Name: tmm_user_transaction tmm_user_transaction_id; Type: CONSTRAINT; Schema: tmm; Owner: -
--

ALTER TABLE ONLY tmm.tmm_user_transaction
    ADD CONSTRAINT tmm_user_transaction_id PRIMARY KEY (user_transaction_id);


--
