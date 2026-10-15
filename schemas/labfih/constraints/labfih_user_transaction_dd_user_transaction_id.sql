-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labfih
-- Object: labfih_user_transaction dd_user_transaction_id
-- Type: CONSTRAINT

-- Name: labfih_user_transaction dd_user_transaction_id; Type: CONSTRAINT; Schema: labfih; Owner: -
--

ALTER TABLE ONLY labfih.labfih_user_transaction
    ADD CONSTRAINT dd_user_transaction_id PRIMARY KEY (user_transaction_id);


--
