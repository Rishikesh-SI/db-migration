-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsrk
-- Object: labsrk_user_transaction dd_user_transaction_id
-- Type: CONSTRAINT

-- Name: labsrk_user_transaction dd_user_transaction_id; Type: CONSTRAINT; Schema: labsrk; Owner: -
--

ALTER TABLE ONLY labsrk.labsrk_user_transaction
    ADD CONSTRAINT dd_user_transaction_id PRIMARY KEY (user_transaction_id);


--
