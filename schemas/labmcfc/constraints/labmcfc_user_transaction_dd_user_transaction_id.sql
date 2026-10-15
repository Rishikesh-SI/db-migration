-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmcfc
-- Object: labmcfc_user_transaction dd_user_transaction_id
-- Type: CONSTRAINT

-- Name: labmcfc_user_transaction dd_user_transaction_id; Type: CONSTRAINT; Schema: labmcfc; Owner: -
--

ALTER TABLE ONLY labmcfc.labmcfc_user_transaction
    ADD CONSTRAINT dd_user_transaction_id PRIMARY KEY (user_transaction_id);


--
