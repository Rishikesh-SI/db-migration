-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labukk
-- Object: labukk_user_transaction dd_user_transaction_id
-- Type: CONSTRAINT

-- Name: labukk_user_transaction dd_user_transaction_id; Type: CONSTRAINT; Schema: labukk; Owner: -
--

ALTER TABLE ONLY labukk.labukk_user_transaction
    ADD CONSTRAINT dd_user_transaction_id PRIMARY KEY (user_transaction_id);


--
