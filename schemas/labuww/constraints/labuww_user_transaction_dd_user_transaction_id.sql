-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labuww
-- Object: labuww_user_transaction dd_user_transaction_id
-- Type: CONSTRAINT

-- Name: labuww_user_transaction dd_user_transaction_id; Type: CONSTRAINT; Schema: labuww; Owner: -
--

ALTER TABLE ONLY labuww.labuww_user_transaction
    ADD CONSTRAINT dd_user_transaction_id PRIMARY KEY (user_transaction_id);


--
