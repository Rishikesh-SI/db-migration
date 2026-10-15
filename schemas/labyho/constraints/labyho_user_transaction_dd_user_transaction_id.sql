-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labyho
-- Object: labyho_user_transaction dd_user_transaction_id
-- Type: CONSTRAINT

-- Name: labyho_user_transaction dd_user_transaction_id; Type: CONSTRAINT; Schema: labyho; Owner: -
--

ALTER TABLE ONLY labyho.labyho_user_transaction
    ADD CONSTRAINT dd_user_transaction_id PRIMARY KEY (user_transaction_id);


--
