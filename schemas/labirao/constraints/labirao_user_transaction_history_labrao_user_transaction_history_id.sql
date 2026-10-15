-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labirao
-- Object: labirao_user_transaction_history labrao_user_transaction_history_id
-- Type: CONSTRAINT

-- Name: labirao_user_transaction_history labrao_user_transaction_history_id; Type: CONSTRAINT; Schema: labirao; Owner: -
--

ALTER TABLE ONLY labirao.labirao_user_transaction_history
    ADD CONSTRAINT labrao_user_transaction_history_id PRIMARY KEY (user_transaction_history_id);


--
