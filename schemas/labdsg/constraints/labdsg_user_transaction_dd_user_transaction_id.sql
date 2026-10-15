-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdsg
-- Object: labdsg_user_transaction dd_user_transaction_id
-- Type: CONSTRAINT

-- Name: labdsg_user_transaction dd_user_transaction_id; Type: CONSTRAINT; Schema: labdsg; Owner: -
--

ALTER TABLE ONLY labdsg.labdsg_user_transaction
    ADD CONSTRAINT dd_user_transaction_id PRIMARY KEY (user_transaction_id);


--
