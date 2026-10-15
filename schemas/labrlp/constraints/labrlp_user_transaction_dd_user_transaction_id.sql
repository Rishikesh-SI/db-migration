-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrlp
-- Object: labrlp_user_transaction dd_user_transaction_id
-- Type: CONSTRAINT

-- Name: labrlp_user_transaction dd_user_transaction_id; Type: CONSTRAINT; Schema: labrlp; Owner: -
--

ALTER TABLE ONLY labrlp.labrlp_user_transaction
    ADD CONSTRAINT dd_user_transaction_id PRIMARY KEY (user_transaction_id);


--
