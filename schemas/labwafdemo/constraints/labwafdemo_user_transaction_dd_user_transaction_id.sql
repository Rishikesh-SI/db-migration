-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwafdemo
-- Object: labwafdemo_user_transaction dd_user_transaction_id
-- Type: CONSTRAINT

-- Name: labwafdemo_user_transaction dd_user_transaction_id; Type: CONSTRAINT; Schema: labwafdemo; Owner: -
--

ALTER TABLE ONLY labwafdemo.labwafdemo_user_transaction
    ADD CONSTRAINT dd_user_transaction_id PRIMARY KEY (user_transaction_id);


--
