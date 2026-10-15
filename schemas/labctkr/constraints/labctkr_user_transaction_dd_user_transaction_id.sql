-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labctkr
-- Object: labctkr_user_transaction dd_user_transaction_id
-- Type: CONSTRAINT

-- Name: labctkr_user_transaction dd_user_transaction_id; Type: CONSTRAINT; Schema: labctkr; Owner: -
--

ALTER TABLE ONLY labctkr.labctkr_user_transaction
    ADD CONSTRAINT dd_user_transaction_id PRIMARY KEY (user_transaction_id);


--
