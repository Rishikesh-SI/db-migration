-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labboost
-- Object: labboost_user_transaction dd_user_transaction_id
-- Type: CONSTRAINT

-- Name: labboost_user_transaction dd_user_transaction_id; Type: CONSTRAINT; Schema: labboost; Owner: -
--

ALTER TABLE ONLY labboost.labboost_user_transaction
    ADD CONSTRAINT dd_user_transaction_id PRIMARY KEY (user_transaction_id);


--
