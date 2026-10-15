-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labw88
-- Object: labw88_user_transaction dd_user_transaction_id
-- Type: CONSTRAINT

-- Name: labw88_user_transaction dd_user_transaction_id; Type: CONSTRAINT; Schema: labw88; Owner: -
--

ALTER TABLE ONLY labw88.labw88_user_transaction
    ADD CONSTRAINT dd_user_transaction_id PRIMARY KEY (user_transaction_id);


--
