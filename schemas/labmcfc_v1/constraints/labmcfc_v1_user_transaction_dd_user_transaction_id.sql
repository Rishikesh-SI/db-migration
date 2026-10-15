-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmcfc_v1
-- Object: labmcfc_v1_user_transaction dd_user_transaction_id
-- Type: CONSTRAINT

-- Name: labmcfc_v1_user_transaction dd_user_transaction_id; Type: CONSTRAINT; Schema: labmcfc_v1; Owner: -
--

ALTER TABLE ONLY labmcfc_v1.labmcfc_v1_user_transaction
    ADD CONSTRAINT dd_user_transaction_id PRIMARY KEY (user_transaction_id);


--
