-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpc
-- Object: labpc_contact scom_contact_id
-- Type: CONSTRAINT

-- Name: labpc_contact scom_contact_id; Type: CONSTRAINT; Schema: labpc; Owner: -
--

ALTER TABLE ONLY labpc.labpc_contact
    ADD CONSTRAINT scom_contact_id PRIMARY KEY (contact_id);


--
