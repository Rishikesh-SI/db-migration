-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrao
-- Object: labrao_user_transaction_history labrao_user_transaction_history_id
-- Type: CONSTRAINT

-- Name: labrao_user_transaction_history labrao_user_transaction_history_id; Type: CONSTRAINT; Schema: labrao; Owner: -
--

ALTER TABLE ONLY labrao.labrao_user_transaction_history
    ADD CONSTRAINT labrao_user_transaction_history_id PRIMARY KEY (user_transaction_history_id);


--
