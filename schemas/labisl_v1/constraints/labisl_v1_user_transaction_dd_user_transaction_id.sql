-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labisl_v1
-- Object: labisl_v1_user_transaction dd_user_transaction_id
-- Type: CONSTRAINT

-- Name: labisl_v1_user_transaction dd_user_transaction_id; Type: CONSTRAINT; Schema: labisl_v1; Owner: -
--

ALTER TABLE ONLY labisl_v1.labisl_v1_user_transaction
    ADD CONSTRAINT dd_user_transaction_id PRIMARY KEY (user_transaction_id);


--
