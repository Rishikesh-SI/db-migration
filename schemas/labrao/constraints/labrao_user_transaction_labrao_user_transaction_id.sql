-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrao
-- Object: labrao_user_transaction labrao_user_transaction_id
-- Type: CONSTRAINT

-- Name: labrao_user_transaction labrao_user_transaction_id; Type: CONSTRAINT; Schema: labrao; Owner: -
--

ALTER TABLE ONLY labrao.labrao_user_transaction
    ADD CONSTRAINT labrao_user_transaction_id PRIMARY KEY (user_transaction_id);


--
