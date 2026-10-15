-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr_beta_08042024
-- Object: labrr_user_transaction dd_user_transaction_id
-- Type: CONSTRAINT

-- Name: labrr_user_transaction dd_user_transaction_id; Type: CONSTRAINT; Schema: labrr_beta_08042024; Owner: -
--

ALTER TABLE ONLY labrr_beta_08042024.labrr_user_transaction
    ADD CONSTRAINT dd_user_transaction_id PRIMARY KEY (user_transaction_id);


--
