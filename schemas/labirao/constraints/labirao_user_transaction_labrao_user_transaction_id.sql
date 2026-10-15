-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labirao
-- Object: labirao_user_transaction labrao_user_transaction_id
-- Type: CONSTRAINT

-- Name: labirao_user_transaction labrao_user_transaction_id; Type: CONSTRAINT; Schema: labirao; Owner: -
--

ALTER TABLE ONLY labirao.labirao_user_transaction
    ADD CONSTRAINT labrao_user_transaction_id PRIMARY KEY (user_transaction_id);


--
