-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt_bkp
-- Object: labgt_contact scom_contact_id
-- Type: CONSTRAINT

-- Name: labgt_contact scom_contact_id; Type: CONSTRAINT; Schema: labgt_bkp; Owner: -
--

ALTER TABLE ONLY labgt_bkp.labgt_contact
    ADD CONSTRAINT scom_contact_id PRIMARY KEY (contact_id);


--
