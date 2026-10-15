-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdd_v1_30april24
-- Object: labdd_v1_user_transaction dd_user_transaction_id
-- Type: CONSTRAINT

-- Name: labdd_v1_user_transaction dd_user_transaction_id; Type: CONSTRAINT; Schema: labdd_v1_30april24; Owner: -
--

ALTER TABLE ONLY labdd_v1_30april24.labdd_v1_user_transaction
    ADD CONSTRAINT dd_user_transaction_id PRIMARY KEY (user_transaction_id);


--
