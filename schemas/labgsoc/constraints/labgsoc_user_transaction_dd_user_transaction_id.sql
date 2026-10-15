-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgsoc
-- Object: labgsoc_user_transaction dd_user_transaction_id
-- Type: CONSTRAINT

-- Name: labgsoc_user_transaction dd_user_transaction_id; Type: CONSTRAINT; Schema: labgsoc; Owner: -
--

ALTER TABLE ONLY labgsoc.labgsoc_user_transaction
    ADD CONSTRAINT dd_user_transaction_id PRIMARY KEY (user_transaction_id);


--
