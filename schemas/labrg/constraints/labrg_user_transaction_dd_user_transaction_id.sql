-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrg
-- Object: labrg_user_transaction dd_user_transaction_id
-- Type: CONSTRAINT

-- Name: labrg_user_transaction dd_user_transaction_id; Type: CONSTRAINT; Schema: labrg; Owner: -
--

ALTER TABLE ONLY labrg.labrg_user_transaction
    ADD CONSTRAINT dd_user_transaction_id PRIMARY KEY (user_transaction_id);


--
