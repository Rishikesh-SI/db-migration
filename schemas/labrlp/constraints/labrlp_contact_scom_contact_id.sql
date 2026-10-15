-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrlp
-- Object: labrlp_contact scom_contact_id
-- Type: CONSTRAINT

-- Name: labrlp_contact scom_contact_id; Type: CONSTRAINT; Schema: labrlp; Owner: -
--

ALTER TABLE ONLY labrlp.labrlp_contact
    ADD CONSTRAINT scom_contact_id PRIMARY KEY (contact_id);


--
